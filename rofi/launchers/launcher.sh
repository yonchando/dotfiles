#!/usr/bin/env bash

dir="$HOME/dotfiles/rofi/launchers"
theme='style'

## Run
rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
