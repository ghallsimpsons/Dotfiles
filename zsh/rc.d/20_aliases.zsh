###
# aliases
###

# ls and grep differs in FreeBSD and Linux
if [[ FreeBSD == $(uname) || Darwin == $(uname) ]] ; then
        alias ls='ls -G'
        alias ll='ls -alhFG'
        alias la='ls -ACFG'
        alias l='ls -CFG'
        alias ls='ls -CFG'
else
        alias ls='ls --color'
        alias ll='ls -alhF --color'
        alias la='ls -ACF --color'
        alias l='ls -CF --color'
        alias ls='ls -CF --color'
        grep_options="--color=auto --exclude-dir='.svn'"
fi

# Show only the defined mailboxes when you open mutt
alias mutt="mutt -y"

# colored commands
for grep_type in grep fgrep egrep ; do
    alias $grep_type="$grep_type $grep_options"
done

# Settings shortcuts
typeset -A settings_files
settings_files=(
zshrc           "~/.zshrc"
hostsettings    "$ZSH_FILES/hosts/$HOSTNAME.zsh"
aliases         "$ZSH_FILES/rc.d/20_aliases.zsh"
zshall          "$ZSH_FILES"

# non-zsh
vimrc           "~/.vimrc"
sshconfig       "~/.ssh/config"
)
for short in ${(k)settings_files}; do
    alias $short="$EDITOR $settings_files[$short]"
done
[[ -f "$ZSH_FILES/hosts/$HOSTNAME" ]] && alias hostsettings="$EDITOR $ZSH_FILES/hosts/$HOSTNAME"
alias resource="source ~/.zshrc"

alias how_deep='echo $(($(ps | wc -l)-3))'

### => alias ...='cd ../../'
#for n in {1,8} ; do
#    eval alias `printf '.%.0s' $(eval "echo {1.."$((n))"}")`="'"cd `printf '../%.0s' $(eval "echo {1.."$(($n-1))"}")`"'";
#done
#BROKEN TODO: FIX

# tmux config: https://github.com/adnichols/tmux_setup
alias fixssh="source ~/bin/fixssh"
