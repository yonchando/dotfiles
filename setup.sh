#!/usr/bin/bash

if [[ "$1" == "pacman" ]]; then
    sudo pacman --needed -S sddm hyprland hyprpaper waybar kitty xdg-desktop-portal-hyprland \
        base-devel iwd networkmanager network-manager-applet \
        rofi cliphist ghostty \
        swaync swayosd \
        git zsh neovim tree-sitter-cli lua luarocks fd tmux exa fzf

    if [[ "$PLATFORM" == "laptop" ]]; then
        sudo pacman --needed -S bluez bluez-utils blueman
    fi

fi

if [[ "$1" == "new" ]]; then
    rm -rf $HOME/.config/nvim
    rm -rf $HOME/.config/hypr
    rm -rf $HOME/.config/waybar
fi

source ./installation.sh
source ./symbolink.sh
