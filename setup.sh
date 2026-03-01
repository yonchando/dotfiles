#!/usr/bin/bash

if [[ "$1" == "new" ]]; then
    rm -rf $HOME/.config/nvim
    rm -rf $HOME/.config/hypr
    rm -rf $HOME/.config/waybar
fi

source ./installation.sh

if [[ ! -L $HOME/.config/ghostty ]]; then
    ln -s $HOME/dotfiles/ghostty $HOME/.config
fi

if [[ ! -L $HOME/.config/hypr ]]; then
    ln -s $HOME/dotfiles/hypr $HOME/.config
fi

if [[ ! -L $HOME/.config/kitty ]]; then
    ln -s $HOME/dotfiles/kitty $HOME/.config
fi

if [[ ! -L $HOME/.config/nvim ]]; then
    ln -s $HOME/dotfiles/nvim $HOME/.config
fi

if [[ ! -L $HOME/.config/rofi ]]; then
    ln -s $HOME/dotfiles/rofi $HOME/.config
fi

if [[ ! -L $HOME/.config/waybar ]]; then
    ln -s $HOME/dotfiles/waybar $HOME/.config
fi

if [[ ! -L /etc/keyd/default.conf ]]; then
    sudo ln -s $HOME/dotfiles/keyd/default.conf /etc/keyd
fi

if [[ ! -L $HOME/.local/bin/tmux-sessionizer ]]; then
    sudo ln -s $HOME/dotfiles/dotfiles/.local/bin/tmux-sessionizer $HOME/.local/bin
fi
