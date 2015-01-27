# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Aliases
alias tmux="TERM=screen-256color tmux -2"

# revert back PS1
settitle() {
    printf "\033k$1\033\\"
}
ssh() {
    command ssh -o 'PermitLocalCommand yes' -o 'LocalCommand host="%n"; echo -ne "\033k${host//\.*/}\033\\"' "$@"
    settitle "bash"
}

# Fix SSH auth socket location so agent forwarding works with tmux
if [ ! -z "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/agent_sock" ] ; then
    unlink "$HOME/.ssh/agent_sock" 2>/dev/null
    ln -s "$SSH_AUTH_SOCK" "$HOME/.ssh/agent_sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/agent_sock"
fi
