###
# aliases
###

# ls and grep differs in FreeBSD and Linux
if [[ FreeBSD == $(uname) || Darwin == $(uname) ]] ; then
        alias ls='ls -G'
else
        alias ls='ls --color'
        grep_options="--color=auto --exclude-dir='.svn'"
fi

# Show only the defined mailboxes when you open mutt
alias mutt="mutt -y"

# colored commands
for grep_type in grep fgrep egrep ; do
    alias $grep_type="$grep_type $grep_options"
done

# some more ls aliases
alias ll='ls -alF'
alias la='ls -ACF'
alias l='ls -CF'
alias ls='ls -CF'

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
    alias mydev="ssh dev-$USER.rescomp.berkeley.edu"

    alias wifi1="ssh dev-wifi-aux.rescomp.berkeley.edu"
    alias wifi2="ssh wifi-aux-0.rescomp.berkeley.edu"
    alias aux="ssh dev-aux.rescomp.berkeley.edu"
    alias carver="ssh ghall@carver.nersc.gov"
    alias hopper="ssh ghall@hopper.nersc.gov"
    alias ceviche="ssh grantlandhall@ceviche.berkeley.edu"
    alias tmux='tmux -2'
    
###I call your bash hax and raise you a stupid
### => alias ...='cd ../../'
#for n in {1,8} ; do
#    eval alias `printf '.%.0s' $(eval "echo {1.."$((n))"}")`="'"cd `printf '../%.0s' $(eval "echo {1.."$(($n-1))"}")`"'";
#done
#BROKEN TODO: FIX

# tmux config: https://github.com/adnichols/tmux_setup
alias fixssh="source ~/bin/fixssh"
