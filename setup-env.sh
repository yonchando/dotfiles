#!/usr/bin/bash

sudo apt update && sudo apt install -y curl 

# Set up oh my zsh
if [[ ! -x $(which zsh) ]]; then
    sudo apt install -y zsh-autosuggestions zsh-syntax-highlighting zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # auto sugesstion
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    # cmd higlight syntax
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
    # cmd autocomplete
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
    # oh my theme powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    # cp zshrc config
    cp ./.zshrc $HOME/.zshrc

    source ~/.zshrc
fi
