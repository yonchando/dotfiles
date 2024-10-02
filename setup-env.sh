#!/usr/bin/bash

sudo cp ~/dotfiles/.local/bin/tmux-sessionizer /usr/local/bin/tmux-sessionizer

# copy tmux copy
if [[ -x $(which tmux) ]]; then
    cp ~/dotfiles/.tmux.conf ~/.tmux.conf
else
    sudo apt install -y tmux
    cp ~/dotfiles/.tmux.conf ~/.tmux.conf
fi

if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# set up neovim
if [[ ! -x $(which nvim) ]]; then
    sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential fd-find fzf ripgrep

    git clone https://github.com/neovim/neovim --depth=1 --branch=stable ~/neovim
    cd ~/neovim && make CMAKE_BUILD_TYPE=Release
    sudo make install
fi

if [[ ! -d ~/.config/nvim ]]; then
    git clone https://github.com/yonchando/dotfiles.git --depth=1 --branch=nvim ~/.config/nvim
fi

# setup node management
if [[ ! -x $(which node) ]]; then
    git clone https://github.com/nvm-sh/nvm.git ~/.nvm
    cd ~/.nvm
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`

    . ./nvm.sh

    nvm install node

    npm install -g neovim
fi

# Set up oh my zsh
if [[ ! -x $(which zsh) ]]; then
    sudo apt install -y zsh-autosuggestions zsh-syntax-highlighting zsh

    # clone oh my zsh
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

    # cp zshrc config
    cp ~/dotfiles/.zshrc ~/.zshrc
    cp ~/dotfiles/.p10k.zsh ~/.p10k.zsh

    # change shell
    chsh -s $(which zsh)

    # auto sugesstion
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    # cmd higlight syntax
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
    # cmd autocomplete
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
    # oh my theme powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    zsh

    source ~/.zshrc
fi

