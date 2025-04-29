#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091,SC2034

add_path() { case :$PATH: in *:$1:*) ;; *) PATH=$1:$PATH;; esac }
path_add() { case :$PATH: in *:$1:*) ;; *) PATH=$PATH:$1;; esac }

add_path "$HOME/.local/bin"

# Enable allexport
set -a

test "$UID"      || UID="$(id -u)"
test "$USER"     || USER="$(id -un)"
test "$HOSTNAME" || HOSTNAME="$(hostname)"

[[ "$OSTYPE" =~ gnu$ ]] && GNU=1

OS_ARCH="$(uname -m)"
OS_NAME="$(uname)"
OS_VERSION="$(uname -r)"

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
[ "$UID" = 0 ] && XDG_RUNTIME_DIR="/run"

# Default install base for npm and some other stuff
PREFIX="$HOME/.local"

# Default programs variables
EDITOR="nvim"
VISUAL="nvim"
PAGER="less"
#MANPAGER="less"
MANPAGER='nvim --cmd ":lua vim.g.noplugins=1" +Man!'

# Cleaning up $HOME dir
# https://wiki.archlinux.org/title/XDG_Base_Directory
# https://github.com/b3nj5m1n/xdg-ninja.git

## To relocate configuration:
INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/config"
GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
IRBRC="$XDG_CONFIG_HOME/ruby/irbrc"
PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
GEF_RC="$XDG_CONFIG_HOME/gdb/gef.rc"
CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache"
PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

## To relocate cache/history:
GDBHISTFILE="$XDG_STATE_HOME/gdb/history"
PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
SQLITE_HISTORY="$XDG_STATE_HOME/sqlite/history"
RLWRAP_HOME="$XDG_STATE_HOME/readline"
LESSHISTFILE="$XDG_STATE_HOME/lesshst"
RANDFILE="$XDG_STATE_HOME/openssl.rnd"
DISTCC_DIR="$XDG_STATE_HOME/distcc"
CCACHE_DIR="$XDG_CACHE_HOME/ccache"

## To relocate runtime data & IPC sockets:
ICEAUTHORITY="$XDG_RUNTIME_DIR/ICEauthority"
XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
TMUX_TMPDIR="$XDG_RUNTIME_DIR/tmux"
SCREENDIR="$XDG_RUNTIME_DIR/screen"
: "${SSH_AUTH_SOCK:="$XDG_RUNTIME_DIR/ssh-agent.socket"}"

TERMINFO="$XDG_DATA_HOME/terminfo"
TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
rvm_path="$XDG_DATA_HOME/rvm"
GEMRC="$XDG_CONFIG_HOME/gem/gemrc"
GEM_HOME="$XDG_DATA_HOME/gem"
GEM_SPEC_CACHE="$XDG_DATA_HOME/gem"
CARGO_HOME="$XDG_DATA_HOME/cargo"
RUSTUP_HOME="$XDG_DATA_HOME/rustup"
VSCODE_PORTABLE="$XDG_DATA_HOME/vscode"

# Disable allexport again
set +a

# Local environment customized settings
if [ -r "$XDG_CONFIG_HOME/bash/bashrc.d/env.${HOSTNAME,,}.sh" ]; then
    source "$XDG_CONFIG_HOME/bash/bashrc.d/env.${HOSTNAME,,}.sh"
fi

if [ -r "$XDG_CONFIG_HOME/bash/bashrc.d/env.local.sh" ]; then
    source "$XDG_CONFIG_HOME/bash/bashrc.d/env.local.sh"
fi

