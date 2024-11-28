#!/usr/bin/env bash

if hash dircolors 2>/dev/null; then
    eval $(dircolors $HOME/.config/dir_colors)
fi
