#!/usr/bin/bash

usage() {
    cat <<USAGE
Usage: $0 [-h|--help] [-l|--link] [step...]
  (no args)    install everything, then symlink dotfiles
  -l, --link   only symlink dotfiles (no installs)
  -h, --help   show this help
  step...      run only those install steps (no symlinking)

$(bash ./installation.sh --help | sed -n 's/^Steps.*: /Steps: /p')
USAGE
}

case "${1:-}" in
    -h|--help)
        usage
        exit
        ;;
    -l|--link)
        shift
        source ./symbolink.sh
        exit
        ;;
esac

source ./installation.sh
(( $# )) || source ./symbolink.sh
