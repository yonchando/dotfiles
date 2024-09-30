# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git aliases zsh-autosuggestions fast-syntax-highlighting zsh-autocomplete)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

# Tree dir show
function tree_dir() { 
    if [[ "$1" ]] then;
        tree -h -d -L "$1"
    else
        tree -h -d -L "$@"
    fi
}

function treelist() {
    if [[ "$1" ]]; then
        tree -h -L "$1"
    else
        tree -h -L "$@"
    fi
}

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# nvm command
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function tmux-sessionizer(){

    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(find /var/www -mindepth 1 -maxdepth 1 -type d | fzf)
    fi

    if [[ -z $selected ]]; then
        return;
    fi

    selected_name=$(basename "$selected" | tr . _)
    tmux_running=$(pgrep tmux)

    if [[ -z $(which tmux) ]]; then
        cd $selected
        return
    fi

    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        tmux new-session -s $selected_name -c $selected
        return
    fi

    if ! tmux has-session -t=$selected_name 2> /dev/null; then
        tmux new-session -ds $selected_name -c $selected
    fi

    if [[ -z $TMUX ]]; then
        tmux attach -t $selected_name
    else
        tmux switch-client -t $selected_name
    fi

}

alias cw="tmux-sessionizer"

alias c='clear'
alias ohe='nvim ~/.zshrc'
alias ohs='source ~/.zshrc'
