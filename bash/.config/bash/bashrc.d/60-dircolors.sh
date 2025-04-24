#!/usr/bin/env bash

if command -v dircolors >/dev/null; then
    eval $(dircolors $HOME/.config/dir_colors)
fi
