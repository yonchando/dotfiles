# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal dotfiles, expected to be cloned at `~/dotfiles` (scripts hardcode `$HOME/dotfiles`). There is no build, lint, or test suite; "running" the repo means executing the setup scripts.

## Branches

- `main` — full Arch Linux / Hyprland desktop setup (hypr Lua modules, waybar, rofi, swaync, kitty, ghostty, nvim, keyd, PowerShell profiles).
- `wsl_linux` — slimmed-down Ubuntu/Debian (apt-based, used under WSL2) setup. Desktop/Wayland configs and nvim are removed here; only shell, tmux, and editor rc files remain.

Check which branch you're on before editing: a config that exists on `main` may be intentionally absent on `wsl_linux`.

## Setup commands

```bash
./setup.sh           # runs installation.sh then symbolink.sh
./setup.sh node go   # only the named install steps (no symlinking)
./setup.sh --link    # symlinks only (same as ./symbolink.sh; -l for short)
./setup.sh --help    # usage + list of step names (-h for short)
./installation.sh    # packages + toolchains only (also accepts step names)
./symbolink.sh       # symlinks only (safe to re-run)
```

`setup.sh` `source`s the other two, so each script's `main "$@"` runs in the same shell. `installation.sh` deliberately uses `set -eo pipefail` without `-u` because `nvm.sh` breaks under `set -u`.

## Architecture

- **`installation.sh`** — one `install_*` function per tool, registered in the `STEPS` array (`name:function`, in run order) that `main()` iterates; with args, only the named steps run. Each is idempotent (checks for an existing install first). Installs apt packages (incl. `xclip` for tmux copy-mode and `libglib2.0-bin` for `gio trash`, plus `trash-cli`), sets zsh as login shell, Python 3 (`python3`, `pip`, `venv` via apt, plus `uv` and a uv-managed `python3.13` in `~/.local/bin` for tools like Mason packages that reject the distro's newer Python), rustup, `exa` via `cargo install` (so it must run after `install_rust`), Go (official tarball into `/usr/local/go`), nvm + LTS node (plus global `tree-sitter-cli` via npm), Neovim (built from the `stable` tag in `~/.local/src/neovim`, packaged with `cpack -G DEB` and installed via `dpkg -i`, so `apt remove neovim` uninstalls it; skipped if `nvim` is already on PATH), and tmux TPM.
- **`symbolink.sh`** — a single `link <src> <dst> [sudo]` helper (`ln -sfn`, creates parent dirs, skips missing sources with a warning). To add a new dotfile, add it to the loop in `link_dotfile` or add a new `link_*` function and call it from `main`.
- **`.dotfiles/`** — files that get symlinked into `$HOME` (`.zshrc`, `.p10k.zsh`, `.tmux.conf`, `.ideavimrc`, `.local.zsh`) plus `.local/bin/tmux-sessionizer` → `~/.local/bin/`.

### Shell / tmux wiring

- `.zshrc` uses **zinit** (auto-cloned on first shell start) for powerlevel10k, OMZ snippets, and zsh plugins — not a full oh-my-zsh install.
- `.zshrc` sources `.aliases.zsh` and `.config.zsh` directly from `~/dotfiles/.dotfiles/` (they are not symlinked), and optionally a machine-local, untracked `~/.local.zsh` (symlinked from the gitignored `.dotfiles/.local.zsh`; sets `WORKING_DIR`).
- `WORKING_DIR` (set in `.local.zsh`) is the space-separated list of roots that `tmux-sessionizer` searches; it's bound to `cw` in the shell and `prefix f` in tmux (prefix is `C-a`).
- tmux plugins are managed by TPM (`~/.tmux/plugins/tpm`); install them with `prefix I`.
