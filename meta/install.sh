#!/usr/bin/env zsh
####
# Dotfiles/meta/install.sh
# simple script to link my dotfiles into $HOME
# @author Jake Teton-Landis <just.1.jake@gmail.com>
# @modified-by Grantland Hall <grantlandhall@berkeley.edu>
####

set -e

# where the dotfiles git repo is checked out to
DOTFILES_DIR="$HOME/.dotfiles"
BUNDLES_DIR="$HOME/bundles"
# list of files to link into homedir
DOTFILES=(
zshrc
zsh

gitconfig
gitignore_global

hgrc

bin
tmux.conf
screenrc

vim
vimrc

psqlrc
)

# hide command output
alias -g no-output=">/dev/null 2>&1"

# ssh
function ssh-config () {
    mkdir -p "$HOME/.ssh/controlmasters"
    # Keep working ssh config out of vcs and merge manually
    cp "$DOTFILES_DIR/ssh_config" "$HOME/.ssh/config"
    chmod 0600 "$DOTFILES_DIR/ssh_config"
    ln -s "$DOTFILES_DIR/ssh_pubkeys" "$HOME/.ssh/authorized_keys"
    chmod 0600 "$DOTFILES_DIR/ssh_pubkeys"
}

# git
function submodules () {
    if which git no-output; then
        pushd "$DOTFILES_DIR" no-output
        git submodule update --init --recursive
        popd no-output
    else
        echo "Cannot get submodules -- git not found"
    fi
}

# desktop config
function desktop-config () {
    local desktop_config_dir="$HOME/.dotfiles/config"
    mkdir -p "$HOME/.config"

    pushd "$HOME" no-output
    for file_fullname in "$desktop_config_dir"/* ; do
	local file="$(basename "$file_fullname")"
        if [ ! -f "$HOME/.config/${file}" ]; then
            echo "Linked .dotfiles/config/${file} -> ~/.config/${file}"
            ln -s "$file_fullname" ".config/${file}"
        else
            echo "skipped because file exists: ~/.config/${file}"
        fi
    done
    popd
}

# link basic files
function dotfiles () {
    pushd "$HOME" no-output
    for file in "${DOTFILES[@]}"; do
        if [ ! -e "$HOME/.${file}" ]; then
            echo "Linked .dotfiles/${file} -> ~/.${file}"
            ln -s "$DOTFILES_DIR/${file}" ".${file}"
        else
            echo "skipped because file exists: ~/.${file}"
        fi
    done

    # bundles dir is defaulty sourced in zshrc.d/02_bundles.zsh
    mkdir -p -v "$BUNDLES_DIR"
    # Make a dummy file so bundles doesn't complain on login
    touch $BUNDLES_DIR/dummy

    pushd "$DOTFILES_DIR" no-output
    # Pull with https, push with ssh so no key needed on login
    git remote add pull https://github.com/ghallsimpsons/Dotfiles -t master 2>/dev/null || true
    git remote set-url origin ssh://git@github.com:/ghallsimpsons/Dotfiles 2>/dev/null || true
    git config branch.master.pushRemote origin 2>/dev/null || true
    git config branch.master.remote pull 2>/dev/null || true
    popd no-output

    popd no-output
}

function brew () {
    git clone "https://github.com/Homebrew/linuxbrew" "$BUNDLES_DIR/linuxbrew"
}

function txtnotify() {
    pushd "$HOME" no-output
    ln -nsf "$DOTFILES_DIR/twilio/twiliorc" ".twiliorc"
    mkdir -p "local/bin"
    mkdir -p "local/man/man1"
    ln -nsf "$DOTFILES_DIR/twilio/txtnotify" "$HOME/local/bin/txtnotify"
    ln -nsf "$DOTFILES_DIR/twilio/txtnotify.man" "$HOME/local/man/man1/txtnotify.1"
    rehash
    touch .twilio.key
    chmod 600 .twilio.key
    which gpg &>/dev/null
    if [ $? -eq 0 ]; then
        echo $(gpg --decrypt $DOTFILES_DIR/twilio/twilio.key 2>/dev/null) > .twilio.key
    else
        echo "Warning: GPG was not found. You must add your key manually to ~/.twilio.key" >&2
    fi
    popd no-output
}

function vim() {
    pushd "$HOME" no-output
    mkdir -p "local/src"
    if [ -d "local/src/vim" ]; then
        pushd "local/src/vim" no-output
        git pull
    else
        git clone "https://github.com/vim/vim" "local/src/vim"
        pushd "local/src/vim" no-output
    fi
    ./configure --prefix=$HOME/local  --enable-cscope --enable-multibyte --with-features=huge
    make -j$(nproc --all --ignore=1)
    make install
    popd no-output
    popd no-output
}

# make sure we param ok?
if [ -z "$*" ]; then
    echo "$0 - error.
Usage:
~/.dotfiles/meta/install.sh [MODULES...]
where 'MODULES' are any of:
  - dotfiles:       the base dotfiles
  - submodules:     get all git submodules
  - ssh-config:     link ssh-config into ~/.ssh/config
  - desktop-config: links in XDG_DESKTOP settings in ~/.config
  - brew:           install linuxhomebrew
  - txtnotify:      install txtnotify command and manpage"
    exit 1
fi

# and whatever else the user requests
for cmd in "$@"; do
    $cmd
done
