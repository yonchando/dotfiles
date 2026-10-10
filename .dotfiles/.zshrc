# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

export EDITOR=nvim
export JAVA_HOME=/usr/lib/jvm/default

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Load starship theme
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit snippet OMZL::key-bindings.zsh

# zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions

source $HOME/dotfiles/.dotfiles/.aliases.zsh
source $HOME/dotfiles/.dotfiles/.config.zsh
[[ -f $HOME/.local.zsh ]] && source $HOME/.local.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
