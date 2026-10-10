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

# Make directory
alias md='mkdir -p'
alias rd=rmdir

# List directory contents
alias lsa='exa -lah'
alias l='exa -lah'
alias ll='exa -lh'
alias la='exa -lAh'

# git
alias gst='git status'
alias gaa='git add .'
alias gcmsg='git commit --message'
alias gc='git commit --verbose'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gl='git pull --rebase'
alias gp='git push'
alias glog='git log --oneline --decorate --graph'

# docker
alias dcls='docker ps -a --format "table {{.Image}}\t{{.Names}}\t{{.Status}}"'
