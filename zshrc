#!/usr/bin/env zsh
####################################################
#  Jake Teton-Landis's                       ZSHRC #
# <just.1.jake@gmail.com>              Winter 2012 #
####################################################
# export all of these settings

# Check for updates if git is installed
which git &>/dev/null
if [ $? -eq 0 ];
then
    pushd ~/.dotfiles >/dev/null
    git fetch pull &>/dev/null
    if [[ "$(git rev-parse HEAD)" != "$(git rev-parse @{u})" ]];
    then
        echo "Your dotfiles aren't up to date! Would you"
        echo "like to update them now? (y/n)"
        read update
        if [[ $update =~ y ]];
        then
            git pull && echo "Updated successfully!"
        fi
    fi
    # Back to where we were
    popd >/dev/null
fi

setopt ALL_EXPORT

MANSECT=1:1p:8:2:3:3p:4:5:6:7:9:0p:n:l:o
TZ="America/Los_Angeles"
HOSTNAME="`hostname`"
PAGER='less'
EDITOR='vim'
# set SVN_EDITOR only if unset
[ -z "$SVN_EDITOR" ] && SVN_EDITOR="$EDITOR"
VISUAL="$EDITOR"
#LANGUAGE=
LC_ALL='en_US.UTF-8'

DOTFILES="$HOME/.dotfiles"
ZSH_FILES="$DOTFILES/zsh"

#### History Settings
HISTFILE="$HOME/.zsh/cache/`hostname`.zhistory"
HISTSIZE=130000
SAVEHIST=100000
setopt NO_ALL_EXPORT

setopt    hist_ignore_dups
setopt NO_hist_verify # enable to review `sudo !!` before executing
setopt    inc_append_history
setopt    extended_history
setopt    hist_expire_dups_first
setopt    hist_ignore_space
# annoying when different terminals do different tasks
setopt NO_share_history

####
# Misc Options
####
setopt    extended_glob
setopt    long_list_jobs

####
# Zshrc.d - most other config
# 00 - 09: functions
# 10 - 19: UI. title, prompt, keybindings, etc
# 20 - 29: Aliases.
# 99     : jokes and deprecated
####
for config in "$ZSH_FILES/rc.d"/* ; do
    # echo "loading $config"
    source "$config"
done

####
# User Scripts Directory in Path
####
prepend_to_path PATH "$HOME/local/bin"
prepend_to_path MANPATH "$HOME/local/bin"

#### Host Settings
[[ -f "$ZSH_FILES/hosts/`hostname`" ]] && source "$ZSH_FILES/hosts/`hostname`"
[[ -f "$ZSH_FILES/hosts/`hostname`.zsh" ]] && source "$ZSH_FILES/hosts/`hostname`.zsh"
[[ -f "$HOME/.zsh.local" ]] && source "$HOME/.zsh.local"
