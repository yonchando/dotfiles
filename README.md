This repo is for personal usage for config `hyprland`, `neovim`, `.ideavimrc`, `.tmux.conf` and `.vimrc`.

### Setup env

Enviroment installed zsh, oh my zsh, lua, luarocks, neovim, tmux and nodejs.

`git clone https://github.com/yonchando/dotfiles.git ~/dotfiles && cd ~/dotfiles`

### Ubuntu

```bash

sudo apt update && sudo apt install -y git curl tmux zsh

chsh -s $(which zsh)

```

### Arch Linux

```sh
    sudo pacman -S sddm hyprpaper hyprlauncher hyprland waybar cliphist ghostty \
        rofi rofi-emoji xdg-desktop-portal-hyprland \
        tlp git neovim lua dolphin tmux zsh

    chsh -s $(which zsh)
```

### Setup run
`./setup.sh`
