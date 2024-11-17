#!/usr/bin/env bash

# Local variables that might be used
test "$UID"      || UID=$(id -u)
test "$USER"     || USER=$(id -un)
test "$HOSTNAME" || HOSTNAME=$(hostname)

add_path() case :$PATH: in *:$1:*) ;; *) PATH=$1:$PATH;; esac
path_add() case :$PATH: in *:$1:*) ;; *) PATH=$PATH:$1;; esac

# Enable allexport
set -a

add_path "$HOME/.local/bin"

# Prefer US English and use UTF-8.
LANG="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
LC_CTYPE="en_US.utf-8"

# Setting default XDG dirs
XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"
XDG_STATE_HOME="$HOME/.local/state"
XDG_CACHE_HOME="$HOME/.cache"
XDG_RUNTIME_DIR="/run/user/$(id -u)"

# Default install base for npm and some other stuff
PREFIX="$HOME/.local"

# Default programs variables
EDITOR="nvim"
VISUAL="nvim"
PAGER="less -r"
MANPAGER="less -X"                      # Don’t clear the screen after quitting a manual page.

# Enable colors in your shell
CLICOLOR=1
TERM="xterm-256color"
GREP_OPTIONS="--color=always"
S_COLORS="auto"                         # Sysstat/iostat - enable colors (probably on by default, now)

# Less - various options
# -e	Quit at second EOF
# -M	Detailed status/prompt
# -q	Use visual instead of audible bell at EOF
# -Q	Always use visual bell
# -R	Pass through formatting sequences
# -F	Immediately quit if one screen
# -X	Don't use alternate screen
# -z-3	Keep 3 line context when scrolling
LESS="e M q R F X z-3"

# Set colors for less. Borrowed from https://wiki.archlinux.org/title/Color_output_in_console#less
# Source: http://unix.stackexchange.com/a/147
# More info: http://unix.stackexchange.com/a/108840
LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Cleaning up $HOME dir
# https://wiki.archlinux.org/title/XDG_Base_Directory

## To relocate configuration:
INPUTRC="$XDG_CONFIG_HOME/bash/inputrc"
GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/config"
GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
IRBRC="$XDG_CONFIG_HOME/ruby/irbrc"
PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache"
NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

## To relocate cache/history:
PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
SQLITE_HISTORY="$XDG_STATE_HOME/sqlite/history"
LESSHISTFILE="$XDG_STATE_HOME/lesshst"	# is the default now
CCACHE_DIR="$XDG_CACHE_HOME/ccache"

## To relocate runtime data & IPC sockets:
ICEAUTHORITY="$XDG_RUNTIME_DIR/ICEauthority"
XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
TMUX_TMPDIR="$XDG_RUNTIME_DIR/tmux"
SCREENDIR="$XDG_RUNTIME_DIR/screen"

rvm_path="$XDG_DATA_HOME/rvm"
GEM_HOME="$XDG_DATA_HOME/gem"
GEM_SPEC_CACHE="$XDG_DATA_HOME/gem"
CARGO_HOME="$XDG_DATA_HOME/cargo"
RUSTUP_HOME="$XDG_DATA_HOME/rustup"
VSCODE_PORTABLE="$XDG_DATA_HOME/vscode"

# Disable allexport again
set +a
