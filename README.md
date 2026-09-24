Personal dotfiles for Ubuntu on WSL2: `zsh`, `tmux`, `.ideavimrc` and `.vimrc`.

> This is the `wsl_linux` branch. The full Arch Linux / Hyprland desktop setup lives on `main`.

### Setup

```bash
sudo apt update && sudo apt install -y git
git clone -b wsl_linux https://github.com/yonchando/dotfiles.git ~/dotfiles && cd ~/dotfiles
./setup.sh
```

The repo must live at `~/dotfiles`; the scripts and `.zshrc` reference that path.

`setup.sh` runs two scripts, which can also be run on their own:

- `./installation.sh` installs packages and tools. Steps whose tool is already installed are skipped.
- `./symbolink.sh` symlinks the dotfiles into `$HOME`. Safe to re-run.

### What gets installed

| Tool | How |
| --- | --- |
| git, curl, tmux, zsh, fzf, ripgrep, xclip | apt |
| Neovim build prerequisites (build-essential, ninja-build, gettext, cmake) | apt |
| zsh as the login shell | `chsh` |
| Rust | rustup |
| exa | `cargo install` |
| Go | official tarball into `/usr/local/go` |
| Node (LTS) + tree-sitter-cli | nvm, then `npm install -g` |
| Neovim | built from the `stable` tag in `~/.local/src/neovim`, installed as a `.deb` |
| tmux plugin manager (TPM) | git clone into `~/.tmux/plugins/tpm` |

zsh plugins and the powerlevel10k prompt are installed by zinit the first time zsh starts.

To uninstall Neovim: `sudo apt remove neovim`.

### What gets linked

| Source | Target |
| --- | --- |
| `.dotfiles/.zshrc`, `.p10k.zsh`, `.tmux.conf`, `.ideavimrc` | `~/` |
| `.dotfiles/.local/bin/tmux-sessionizer` | `~/.local/bin/` |

### After setup

- Open a new terminal (or log out and back in) so zsh becomes the shell.
- In tmux, press `Ctrl-a` then `I` to install the tmux plugins.
- Put machine-specific shell settings in `~/.dev.zsh`. `.zshrc` loads it if it exists, and it is not tracked in the repo.
