#!/usr/bin/env bash

dir="$HOME/dotfiles/rofi/clipboards"
theme='style'

# -bind = $mainMod, V, exec, cliphist list | rofi -theme arch-dark -dmenu -display-columns 2 |

## Run
cliphist list |
    rofi -dmenu -theme ${dir}/${theme}.rasi -p "" |
    cliphist decode | wl-copy
