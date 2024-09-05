# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/opt/gradle/gradle-8.3/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:/usr/lib/jvm/jdk-20/bin:$HOME/.cargo/bin"
export JAVA_HOME="/usr/lib/jvm/java-1.17.0-openjdk-amd64"
export PATH="$PATH:$HOME/.local/bin"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git docker docker-compose aliases kubectl tmux mvn rust zsh-autosuggestions fast-syntax-highlighting zsh-autocomplete)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

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

# >>>> Vagrant command completion (start)
fpath=(/opt/vagrant/embedded/gems/gems/vagrant-2.3.7/contrib/zsh $fpath)
compinit
# <<<<  Vagrant command completion (end)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set audio default
pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo
# pactl set-default-source alsa_input.usb-Razer_Inc_Razer_Seiren_X_UC1920L01202607-00.analog-stereo
#

# nvm command
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias art=artisan

function artisan() {
    php artisan "$@"
}

LOTTERY=root@209.97.166.51

function _ssh() {
  if [[ "$1" == "lottery" ]]
  then
      ssh root@209.97.166.51

  elif [[ "$1" == "omega" ]]
  then
      ssh root@143.198.83.2

  else
      echo "list lottery, omega"
  fi

}

function php74() {
    sudo update-alternatives --set php /usr/bin/php7.4
    sudo update-alternatives --set php-config /usr/bin/php-config7.4
    sudo update-alternatives --set phpize /usr/bin/phpize7.4
}

function php81() {
    sudo update-alternatives --set php /usr/bin/php8.1
    sudo update-alternatives --set php-config /usr/bin/php-config8.1
    sudo update-alternatives --set phpize /usr/bin/phpize8.1
}

function php82() {
    sudo update-alternatives --set php /usr/bin/php8.2
    sudo update-alternatives --set php-config /usr/bin/php-config8.2
    sudo update-alternatives --set phpize /usr/bin/phpize8.2
}

function tmux-sessionizer(){
    if [[ $# -eq 1 ]]; then
    selected=$1
    else
        selected=$(find ~/code ~/.config -mindepth 2 -maxdepth 2 -type d | fzf)
    fi
    
    if [[ -z $selected ]]; then
        exit 0
    fi
    
    selected_name=$(basename "$selected" | tr . _)
    tmux_running=$(pgrep tmux)
    
    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        tmux new-session -s $selected_name -c $selected
        exit 0
    fi
    
    if ! tmux has-session -t=$selected_name 2> /dev/null; then
        tmux new-session -ds $selected_name -c $selected
    fi
    
    tmux switch-client -t $selected_name

}
alias cw="tmux-sessionizer"

alias c='clear'
alias hr='cd ~/Homestead && vagrant up'
alias hs='ssh vagrant@127.0.0.1 -p 2222'
alias hre='cd ~/Homestead && vagrant reload --provision'
alias hh='cd ~/Homestead && nvim'
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
alias ohe='nvim ~/.zshrc'
alias ohs='source ~/.zshrc'


