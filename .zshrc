export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# we need dircolors binary
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH"

# sed
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

# https://golang.org/doc/code.html#GOPATH
export GOPATH="$HOME/.go"
export PATH="$HOME/.go/bin:$PATH"

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

export ZPLUG_HOME=~/.config/zplug
#source $(brew --prefix zplug)/init.zsh
source "/usr/local/opt/zplug/init.zsh"

zplug "lib/completion", from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh # Enable emacs shortcuts
zplug "plugins/knife", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/rvm", from:oh-my-zsh
zplug "plugins/gem", from:oh-my-zsh
zplug "plugins/vagrant", from:oh-my-zsh
zplug "plugins/aws", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
HIST_STAMPS="mm/dd/yyyy"
zplug "zsh-users/zsh-autosuggestions", nice:10
zplug "zsh-users/zsh-syntax-highlighting", nice:19 # Should be loaded last.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
zplug "seebi/dircolors-solarized"

# Set theme
setopt PROMPT_SUBST
zplug "themes/agnoster", from:oh-my-zsh
# http://stackoverflow.com/questions/28491458/zsh-agnoster-theme-showing-machine-name
DEFAULT_USER=$(id -un)

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# dircolors
eval $(dircolors $ZPLUG_HOME/repos/seebi/dircolors-solarized/dircolors.256dark)

# Then, source plugins and add commands to $PATH
zplug load --verbose

### Autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"

### Oh-my-zsh
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

### Aliases
alias sudo='sudo '
alias ls='ls --color'
alias ll='ls -la --color'
alias curl-8080='curl -O -J -L --proxy socks5h://localhost:8080'
alias gam='python /Users/oleksii_kravchenko/Work/ippt/abb_gam/GAM-3.51/gam.py'
alias vim="nvim"
alias vimdiff="nvim -d"

### Vars
export EDITOR='nvim'
export SHELL='/usr/local/bin/zsh'

### FZF
# always receive unique search results
setopt HIST_IGNORE_ALL_DUPS
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'

### Fix SSH auth socket location so agent forwarding works with tmux
if [ ! -z "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/agent_sock" ] ; then
    unlink "$HOME/.ssh/agent_sock" 2>/dev/null
    ln -s "$SSH_AUTH_SOCK" "$HOME/.ssh/agent_sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/agent_sock"
fi

### Use SSH agent
if command -v keychain &>/dev/null && [[ -r ~/.ssh/identity ]]; then
  eval `keychain --quiet --eval identity`
fi

### Include .envrc belongs to project
[[ -f ~/.envrc ]] && source ~/.envrc
if [[ "$PWD" =~ ^${HOME}/Work/[^/]+$ ]]; then
  include="${PWD}/.envrc"
  [[ -f "$include" ]] && source "$include"
fi

### RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
