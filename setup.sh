#!/usr/bin/bash

if [[ "$1" == "new" ]]; then
    sudo pacman -S ghostty rofi rofi-emoji waybar xdg-desktop-portal-hyprland \
        hyprpaper hyprlauncher hyprland tlp


    rm -rf $HOME/.config/nvim
    rm -rf $HOME/.config/hypr
    rm -rf $HOME/.config/waybar

elif [[ "$1" == "start-service" ]]; then
    sudo systemctl start tlp
fi


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
