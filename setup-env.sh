#!/usr/bin/bash

sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential fd-find fzf ripgrep wget tree

if [[ -x $(which tmux-sessionizer) ]]; then
    sudo cp -r ~/dotfiles/.local ~/.local
fi

# install tmux
if [[ -x $(which tmux) ]]; then
    cp ~/dotfiles/.tmux.conf ~/.tmux.conf
else
    sudo apt install -y tmux
    cp ~/dotfiles/.tmux.conf ~/.tmux.conf
fi
# tmux plugins manager
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# set up neovim
if [[ ! -x $(which nvim) ]]; then
    git clone https://github.com/neovim/neovim --depth=1 --branch=stable ~/neovim
    cd ~/neovim && make CMAKE_BUILD_TYPE=Release
    cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
    sudo apt install ./nvim-linux64.deb

    rm -rf ~/neovim
fi

# neovim config repo
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
    cd ~
    sudo apt install -y zsh-autosuggestions zsh-syntax-highlighting zsh

    # clone oh my zsh
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

    # cp zshrc config with theme power10k
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

if [[ ! -x $(which lua) ]]; then
    cd ~
    curl -L -R -O https://www.lua.org/ftp/lua-5.4.7.tar.gz
    tar zxf lua-5.4.7.tar.gz
    cd lua-5.4.7
    make all install

    wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz
    tar zxpf luarocks-3.11.1.tar.gz
    cd luarocks-3.11.1
    ./configure && make && sudo make install
    sudo luarocks install luasocket

    cd ~ && rm -rf lua-*
fi
