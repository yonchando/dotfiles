#!/usr/bin/bash

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
