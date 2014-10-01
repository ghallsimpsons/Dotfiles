if [[ ! -S $SSH_AUTH_SOCK ]]
then
    eval `ssh-agent` >/dev/null
fi
if ! ssh-add -l >/dev/null
then
    ssh-add >/dev/null
fi
