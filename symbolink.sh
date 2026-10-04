#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"

# link <source> <target> [sudo]
link() {
    local src="$1" dst="$2" run="${3:-}"

    if [[ ! -e "$src" ]]; then
        echo "Skip: source not found: $src" >&2
        return
    fi

    $run mkdir -p "$(dirname "$dst")"
    $run ln -sfn "$src" "$dst"
    echo "Linked: $dst -> $src"
}

link_local_bin() {
    link "$DOTFILES/.dotfiles/.local/bin/tmux-sessionizer" "$HOME/.local/bin/tmux-sessionizer"
}

init_local_zsh() {
    local f="$DOTFILES/.dotfiles/.local.zsh"
    [[ -e "$f" ]] && return
cat > "$f" <<'EOF'
export WORKING_DIR="$HOME $HOME/.config"
EOF
    echo "Created: $f"
}

link_dotfile() {
    local f
    init_local_zsh
    for f in .zshrc .p10k.zsh .tmux.conf .ideavimrc .local.zsh; do
        link "$DOTFILES/.dotfiles/$f" "$HOME/$f"
    done
}

main() {
    link_local_bin
    link_dotfile
}

main "$@"
