#!/usr/bin/bash

if [[ "$1" == "pacman" ]]; then
    sudo pacman --needed -S sddm hyprpaper hyprlauncher hyprland waybar kitty xdg-desktop-portal-hyprland \
        rofi cliphist ghostty \
        zsh \
        swaync swayosd \
        git neovim lua tmux exa fzf
fi

if [[ "$1" == "new" ]]; then
    rm -rf $HOME/.config/nvim
    rm -rf $HOME/.config/hypr
    rm -rf $HOME/.config/waybar
fi

source ./installation.sh
source ./symbolink.sh
