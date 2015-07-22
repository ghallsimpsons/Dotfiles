###
# aliases
###

# ls and grep differs in FreeBSD and Linux
if [[ FreeBSD == $(uname) || Darwin == $(uname) ]] ; then
        alias ls='ls -G'
        alias ll='ls -alFG'
        alias la='ls -ACFG'
        alias l='ls -CFG'
        alias ls='ls -CFG'
else
        alias ls='ls --color'
        alias ll='ls -alF --color'
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

typeset -A ssh_hosts
ssh_hosts=(
# rescomp
hal         "hal.rescomp.berkeley.edu"
irc         "irc.housing.berkeley.edu"
stargate    "stargate.housing.berkeley.edu"
)
for short in ${(k)ssh_hosts}; do
    alias $short="ssh $ssh_hosts[$short]"
done

### Rescomp Dev hosts
for n in {1..15} ; do
    alias dev$n="ssh dev-www$n.rescomp.berkeley.edu"
done
    alias bsd='ssh dev-grantlandhall-bsd.rescomp.berkeley.edu'
    alias rel='ssh dev-grantlandhall-rel.rescomp.berkeley.edu'
    alias proxy='ssh dev-hoth.rescomp.berkeley.edu'
    alias carver="ssh ghall@carver.nersc.gov"
    alias hopper="ssh ghall@hopper.nersc.gov"
    alias ceviche="ssh grantlandhall@ceviche.berkeley.edu"
    alias tmux='tmux -2'
    
### => alias ...='cd ../../'
#for n in {1,8} ; do
#    eval alias `printf '.%.0s' $(eval "echo {1.."$((n))"}")`="'"cd `printf '../%.0s' $(eval "echo {1.."$(($n-1))"}")`"'";
#done
#BROKEN TODO: FIX

# tmux config: https://github.com/adnichols/tmux_setup
alias fixssh="source ~/bin/fixssh"
