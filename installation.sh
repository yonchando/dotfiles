#!/usr/bin/env bash
set -eo pipefail   # no "-u" here: nvm.sh breaks with "set -u"

install_packages() {
    sudo apt update
    # libglib2.0-bin provides "gio trash"; trash-cli provides trash-put etc.
    sudo apt install -y curl tmux zsh fzf ripgrep xclip build-essential libglib2.0-bin trash-cli

    # Neovim build prerequisites
    sudo apt install -y ninja-build gettext cmake
}

set_default_shell() {
    local zsh_path
    zsh_path="$(command -v zsh)"
    if [[ "$SHELL" != "$zsh_path" ]]; then
        chsh -s "$zsh_path"
    fi
}

install_python() {
    sudo apt install -y python3 python3-pip python3-venv
    python3 --version

    # uv provides older Pythons (e.g. python3.13 in ~/.local/bin) for tools
    # that don't support the distro's python3 yet; Mason picks them up by name
    export PATH="$HOME/.local/bin:$PATH"
    if ! command -v uv >/dev/null 2>&1; then
        # .zshrc already adds ~/.local/bin to PATH; don't let the installer edit it
        curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
    fi
    uv python install 3.13
    python3.13 --version
}

install_rust() {
    if ! command -v rustup >/dev/null 2>&1 && [[ ! -x "$HOME/.cargo/bin/rustup" ]]; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    fi
    . "$HOME/.cargo/env"
    rustc --version
}

install_exa() {
    # cargo may not be on PATH yet when this runs without install_rust
    [[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
    if ! command -v cargo >/dev/null 2>&1; then
        echo "Skip exa: cargo not found (run './setup.sh rust' first)" >&2
        return
    fi
    if ! command -v exa >/dev/null 2>&1; then
        cargo install exa
    fi
    exa --version
}

install_go() {
    local arch version current

    # Detect CPU type
    case "$(uname -m)" in
        x86_64)  arch="amd64" ;;
        aarch64) arch="arm64" ;;
        *) echo "Unsupported arch: $(uname -m)" >&2; return 1 ;;
    esac

    # Latest version, e.g. "go1.23.2"
    version="$(curl -fsSL "https://go.dev/VERSION?m=text" | head -n1)"

    # Version installed now (empty if none)
    if [[ -x /usr/local/go/bin/go ]]; then
        current="$(/usr/local/go/bin/go version | awk '{print $3}')"
    fi

    if [[ "$current" != "$version" ]]; then
        echo "Installing $version ..."
        curl -fsSL "https://go.dev/dl/${version}.linux-${arch}.tar.gz" -o /tmp/go.tar.gz
        sudo rm -rf /usr/local/go
        sudo tar -C /usr/local -xzf /tmp/go.tar.gz
        rm /tmp/go.tar.gz
    fi

    export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"
    go version
}

install_node() {
    export NVM_DIR="$HOME/.nvm"

    if [[ ! -d "$NVM_DIR" ]]; then
        git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
        (
            cd "$NVM_DIR"
            git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" "$(git rev-list --tags --max-count=1)")"
        )
    fi

    . "$NVM_DIR/nvm.sh"
    nvm install --lts
    node --version

    if ! command -v tree-sitter >/dev/null 2>&1; then
        npm install -g tree-sitter-cli
    fi
    tree-sitter --version
}

install_neovim() {
    local src="$HOME/.local/src/neovim"

    if command -v nvim >/dev/null 2>&1; then
        nvim --version | head -n1
        return
    fi

    if [[ ! -d "$src" ]]; then
        git clone https://github.com/neovim/neovim.git "$src"
    fi

    (
        cd "$src"
        git fetch --tags --force
        git checkout stable
        make distclean
        # Clean PATH: Windows entries leaked in by WSL can break the build
        PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
            make CMAKE_BUILD_TYPE=RelWithDebInfo
        # Package as .deb so it can be removed cleanly with "sudo apt remove neovim"
        cd build
        cpack -G DEB
        sudo dpkg -i nvim-linux-*.deb
    )

    nvim --version | head -n1
}

install_tmux_plugin() {
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi
}

# Step name -> function, in install order (used when no args are given)
STEPS=(
    packages:install_packages
    shell:set_default_shell
    python:install_python
    rust:install_rust
    exa:install_exa
    go:install_go
    node:install_node
    neovim:install_neovim
    tmux:install_tmux_plugin
)

usage() {
    echo "Usage: $0 [-h|--help] [step...]"
    echo "Steps (default: all): ${STEPS[*]%%:*}"
}

main() {
    local step entry fn
    local -a fns=()

    if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
        usage
        return
    fi

    if (( $# == 0 )); then
        for entry in "${STEPS[@]}"; do fns+=("${entry#*:}"); done
    else
        for step in "$@"; do
            fn=""
            for entry in "${STEPS[@]}"; do
                [[ "${entry%%:*}" == "$step" ]] && fn="${entry#*:}"
            done
            if [[ -z "$fn" ]]; then
                echo "Unknown step: $step (see $0 --help)" >&2
                return 1
            fi
            fns+=("$fn")
        done
    fi

    for fn in "${fns[@]}"; do
        "$fn"
    done
}

main "$@"
