#!/usr/bin/bash

if [[ "$1" == "new" ]]; then
    sudo pacman -S sddm hyprpaper hyprlauncher hyprland waybar cliphist ghostty \
        rofi rofi-emoji xdg-desktop-portal-hyprland \
        tlp git neovim lua dolphin tmux

    rm -rf $HOME/.config/nvim
    rm -rf $HOME/.config/hypr
    rm -rf $HOME/.config/waybar

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

if [[ ! -L /etc/keyd/default.conf ]]; then
    sudo ln -s $HOME/dotfiles/keyd/default.conf /etc/keyd
fi
