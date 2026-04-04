#!/usr/bin/bash

link_config() {
    if [[ ! -L $HOME/.config/ghostty ]]; then
        rm -rf $HOME/.config/ghostty
        ln -s $HOME/dotfiles/ghostty $HOME/.config
    fi

    if [[ ! -L $HOME/.config/hypr ]]; then
        rm -rf $HOME/.config/hypr
        ln -s $HOME/dotfiles/hypr $HOME/.config
    fi

    if [[ ! -L $HOME/.config/kitty ]]; then
        rm -rf $HOME/.config/kitty
        ln -s $HOME/dotfiles/kitty $HOME/.config
    fi

    if [[ ! -L $HOME/.config/nvim ]]; then
        rm -rf $HOME/.config/nvim
        ln -s $HOME/dotfiles/nvim $HOME/.config
    fi

    if [[ ! -L $HOME/.config/waybar ]]; then
        rm -rf $HOME/.config/waybar
        ln -s $HOME/dotfiles/waybar $HOME/.config
    fi

    if [[ ! -L $HOME/.config/rofi ]]; then
        rm -rf $HOME/.config/rofi
        ln -s $HOME/dotfiles/rofi $HOME/.config
    fi

    if [[ ! -L $HOME/.config/swaync ]]; then
        rm -rf $HOME/.config/swaync
        ln -s $HOME/dotfiles/swaync $HOME/.config/swaync
    fi
}

link_keyd() {
    if [[ ! -L /etc/keyd/default.conf ]]; then
        sudo rm -rf /etc/keyd
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
        rm -rf $HOME/.zshrc
        ln -s $HOME/dotfiles/.dotfiles/.zshrc $HOME
    fi

    if [[ ! -L $HOME/.p10k.zsh ]]; then
        rm -rf $HOME/.p10k.zsh
        ln -s $HOME/dotfiles/.dotfiles/.p10k.zsh $HOME
    fi

    if [[ ! -L $HOME/.tmux.conf ]]; then
        rm -rf $HOME/.tmux.conf
        ln -s $HOME/dotfiles/.dotfiles/.tmux.conf $HOME
    fi

    if [[ ! -L $HOME/.ideavimrc ]]; then
        rm -rf $HOME/.ideavimrc
        ln -s $HOME/dotfiles/.dotfiles/.ideavimrc $HOME
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
