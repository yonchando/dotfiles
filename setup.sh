#!/usr/bin/bash

if [[ "$1" == "pacman" ]]; then
    sudo pacman --needed -S sddm hyprland hyprpaper hyprshot waybar kitty xdg-desktop-portal-hyprland \
        base-devel iwd networkmanager network-manager-applet nautilus \
        rofi cliphist ghostty \
        swaync swayosd \
        git zsh neovim tree-sitter-cli lua luarocks fd tmux exa fzf \
        bluez bluez-utils blueman

fi

if [[ "$1" == "new" ]]; then
    rm -rf $HOME/.config/nvim
    rm -rf $HOME/.config/hypr
    rm -rf $HOME/.config/waybar
fi

source ./installation.sh
source ./symbolink.sh
