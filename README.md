This repo is for personal usage for config `hyprland`, `neovim`, `.ideavimrc`, `.tmux.conf` and `.vimrc`.

### Setup env

Enviroment installed zsh, oh my zsh, lua, luarocks, neovim, tmux and nodejs.

### Neovim

`git clone --branch nvim_12 https://github.com/yonchando/dotfiles.git ~/.config/nvim`

### Ubuntu

```bash

sudo apt update && sudo apt install -y git curl tmux zsh

chsh -s $(which zsh)

`git clone https://github.com/yonchando/dotfiles.git ~/dotfiles && cd ~/dotfiles && git chekcout wsl_linux`


```

### Arch Linux

```sh
sudo pacman --needed -S sddm hyprpaper hyprlauncher hyprland waybar cliphist ghostty \
    rofi rofi-emoji xdg-desktop-portal-hyprland \
    tlp git neovim lua dolphin tmux zsh

chsh -s $(which zsh)

`git clone https://github.com/yonchando/dotfiles.git ~/dotfiles && cd ~/dotfiles`

```

### Setup run
`./setup.sh`
