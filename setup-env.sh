#!/usr/bin/bash

# Set up oh my zsh
if [[ ! -x $(which zsh) ]]; then
    sudo apt install -y zsh-autosuggestions zsh-syntax-highlighting zsh

    # clone oh my zsh
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

    # cp zshrc config
    cp ~/dotfiles/.zshrc ~/.zshrc

    # change shell
    chsh -s $(which zsh)

    # auto sugesstion
    git clone https://github.com/zsh-users/zsh-autosuggestions.git {$ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    # cmd higlight syntax
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
    # cmd autocomplete
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
    # oh my theme powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    source ~/.zshrc
fi

# copy tmux copy
if [[ -x $(which tmux) ]]; then
    cp ~/dotfiles/.tmux.conf ~/.tmux.conf
else
    sudo apt install -y tmux
    cp ~/dotfiles/.tmux.conf ~/.tmux.conf
fi
