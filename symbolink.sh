#!/usr/bin/bash

link_config() {
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

    if [[ ! -L $HOME/.config/waybar ]]; then
        ln -s $HOME/dotfiles/waybar $HOME/.config
    fi

    if [[ ! -L $HOME/.config/rofi ]]; then
        ln -s $HOME/dotfiles/rofi $HOME/.config
    fi

    if [[ ! -L $HOME/.config/swaync ]]; then
        ln -s $HOME/dotfiles/swaync $HOME/.config/swaync
    fi
}

link_keyd() {
    if [[ ! -L /etc/keyd/default.conf ]]; then
        sudo ln -s $HOME/dotfiles/keyd/default.conf /etc/keyd
    fi
}

link_local_bin() {
    if [[ ! -L $HOME/.local/bin/tmux-sessionizer ]]; then

        if [[ ! -d $HOME/.local/bin ]]; then
            mkdir -p $HOME/.local/bin
        fi

        ln -s $HOME/dotfiles/.dotfiles/.local/bin/tmux-sessionizer $HOME/.local/bin
    fi
}

link_dotfile() {
    if [[ ! -L $HOME/.zshrc ]]; then
        ln -s $HOME/dotfiles/.dotfiles/.zshrc $HOME
    fi

    if [[ ! -L $HOME/.p10k.zsh ]]; then
        ln -s $HOME/dotfiles/.dotfiles/.p10k.zsh $HOME
    fi

    if [[ ! -L $HOME/.tmux.conf ]]; then
        ln -s $HOME/dotfiles/.dotfiles/.tmux.conf $HOME
    fi
}

#Main
main() {
    link_config
    link_keyd
    link_local_bin
    link_dotfile
}

main
