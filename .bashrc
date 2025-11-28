export VISUAL="/usr/bin/vim"
export EDITOR="$VISUAL"

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias s='git status'
alias aa='git add --all'
alias a='git add'
alias c='git commit -m'
alias p='git push'
alias pl='git pull'

export XDG_CONFIG_HOME="$HOME/.config"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$HOME/.local/bin:/home/acme/Code/docker/target/release/:$PATH"

PS1='[\u@\h \W]\$ '
