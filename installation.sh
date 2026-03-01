#!/usr/bin/bash

# Set up oh my zsh
if [[ ! -d $HOME/.oh-my-zsh ]]; then
    # clone oh my zsh
    git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh

    # cp zshrc config with theme power10k
    ln -s $HOME/dotfiles/dotfiles/.zshrc $HOME
    ln -s $HOME/dotfiles/dotfiles/.p10k.zsh $HOME

    # cmd higlight syntax
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

    # oh my theme powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    source ~/.zshrc
fi

# setup node management
if [[ ! -x $(which node) ]]; then
    export NVM_DIR="$HOME/.nvm" && (
        git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
        cd "$NVM_DIR"
        git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))
    ) && \. "$NVM_DIR/nvm.sh"

    nvm install node
fi

if [[ -x $(which tmux) && ! -L $HOME/.tmux.conf ]]; then
    ln -s $HOME/dotfiles/dotfiles/.tmux.conf $HOME
fi

# tmux plugins manager
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
