#!/usr/bin/bash

function aptUpdate() {
    sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential fd-find fzf ripgrep wget tree
}

function tmux() {
    # install tmux
    if [[ -x $(which tmux) ]]; then
        cp ~/dotfiles/.tmux.conf ~/.tmux.conf
    else
        sudo apt install -y tmux
        cp ~/dotfiles/.tmux.conf ~/.tmux.conf
    fi

    # tmux plugins manager
    if [[ ! -d ~/.tmux/plugins/tpm ]]; then
        if [[ ! -d ~/.config ]]; then
            mkdir ~/.config
        fi

        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    if [[ -x $(which tmux-sessionizer) ]]; then

        if [[ ! -d ~/.local ]]; then
            mkdir ~/.local
        fi

        sudo cp -r ~/dotfiles/.local/bin ~/.local/bin
    fi
}

function neovim() {
    # set up neovim
    if [[ ! -x $(which nvim) ]]; then
        git clone https://github.com/neovim/neovim --depth=1 --branch=stable ~/neovim
        cd ~/neovim && make CMAKE_BUILD_TYPE=Release
        cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
        sudo apt install ./nvim-linux64.deb
    fi

    # neovim config repo
    if [[ ! -d ~/.config/nvim ]]; then
        git clone https://github.com/yonchando/dotfiles.git --depth=1 --branch=nvim ~/.config/nvim
    fi
}

function node() {
    # setup node management
    if [[ ! -x $(which node) ]]; then
        git clone https://github.com/nvm-sh/nvm.git ~/.nvm
        cd ~/.nvm
        git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))

        . ./nvm.sh

        nvm install node

        npm install -g neovim
    fi
}

function ohMyZsh() {
    # Set up oh my zsh
    if [[ ! -d ~/.oh-my-zsh ]]; then
        cd ~
        sudo apt install -y zsh-autosuggestions zsh-syntax-highlighting

        # clone oh my zsh
        git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

        # cp zshrc config with theme power10k
        cp ~/dotfiles/.zshrc ~/.zshrc
        cp ~/dotfiles/.p10k.zsh ~/.p10k.zsh

        # auto sugesstion
        git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        # cmd higlight syntax
        git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
        # cmd autocomplete
        git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
        # oh my theme powerlevel10k
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

        source ~/.zshrc
    fi
}

case ${1,,} in
node)
    node
    ;;
tmux)
    tmux
    ;;
neovim)
    neovim
    ;;
ohMyZsh)
    ohMyZsh
    ;;
*)
    aptUpdate
    tmux
    neovim
    node
    ohMyZsh
    ;;
esac
