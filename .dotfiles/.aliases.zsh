alias c="clear"

# tmux
alias cw="tmux-sessionizer"

tw() { tmux new -s "$(basename "$PWD" | tr . _)"; }

# dotfile
alias ohd='nvim ~/dotfiles'
alias ohw='nvim ~/dotfiles/.dotfiles/.local.zsh'
alias ohe='nvim ~/.zshrc'
alias ohs='source ~/.zshrc'

# tree listing
alias ltd='tree -h -d -L'
alias lt='tree -h -L'

# ls dir
alias ls='exa'
alias ll='exa -lh'
alias lsa='exa -lah'

# docker
alias dcls='docker ps -a --format "table {{.Image}}\t{{.Names}}\t{{.Status}}"'
