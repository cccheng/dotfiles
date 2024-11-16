#!/usr/bin/env bash

# Prefer US English and use UTF-8.
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.utf-8"

# Setting default XDG dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# Enable colors in your shell
export CLICOLOR=1
export TERM="xterm-256color"
export GREP_OPTIONS="--color=always"

# Set colors for less. Borrowed from https://wiki.archlinux.org/title/Color_output_in_console#less
# Source: http://unix.stackexchange.com/a/147
# More info: http://unix.stackexchange.com/a/108840
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Default programs variables
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less -r"

export HISTSIZE="32768"                         # Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTFILESIZE="${HISTSIZE}"
export HISTCONTROL=ignorespace:erasedups        # Omit duplicates and commands that begin with a space from history.
# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
export HISTTIMEFORMAT="%F %T "
# Don't record some commands
#export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
HISTFILE="$XDG_DATA_HOME/bash/history"

export MANPAGER="less -X"                       # Don’t clear the screen after quitting a manual page.

export GPG_TTY="$(tty)"

# Cleaning up $HOME dir
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
#export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
