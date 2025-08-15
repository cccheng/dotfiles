#!/usr/bin/env bash
# shellcheck disable=SC2139

alias vim="nvim -p"
alias vimdiff="nvim -d"
alias view="nvim -R"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Passing aliases
# https://wiki.archlinux.org/title/Sudo#Passing_aliases
if [[ "$OSTYPE" =~ linux ]]; then
    alias sudo="sudo -u root -g adm "
fi

# Verbosity and settings that you pretty much just always are going to want.
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv ${GNU:+--one-file-system}"
# alias rm="trash"

alias ls="\ls -F --color=auto ${GNU:+--group-directories-first -v}"
alias ll="ls -lhi ${GNU:+--time-style='+[%Y-%m-%d %H:%M]'}"
alias la="ll -A"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep="grep --color=auto"
alias fgrep="grep --color=auto -F"
alias egrep="grep --color=auto -E"
alias diff="diff --color=auto"
alias ip="ip --color=auto"

alias dmesg="dmesg --color=auto -e -x"
alias which="which -a"
alias ps="ps auxw"
alias fd="fd --strip-cwd-prefix --hidden --follow --exclude .git"

# pipx install neovim-remote
alias nvr="nvr --servername=$XDG_RUNTIME_DIR/nvim.pipe -s --remote-tab"
alias nvr-s="\nvr --servername=$XDG_RUNTIME_DIR/nvim.pipe --remote -o"
alias nvr-v="\nvr --servername=$XDG_RUNTIME_DIR/nvim.pipe --remote -O"

alias path='echo -e "${PATH//:/\\n}"'
alias net-ls="netstat -lntp"
alias net-ll="ss -plat"
alias net-ports="lsof -PiTCP -sTCP:LISTEN"

# Reload the shell (i.e. invoke as a login shell)
alias reload='exec "$SHELL" -l'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
# alias map="xargs -n1"
alias m="xargs -n1"

# Switch to a temporary directory
alias cdtmp='cd "$(mktemp -d)"'

# Convenient `open` and `trash` commands for Linux and macOS
if [[ "$OSTYPE" =~ linux ]]; then
    command -v xdg-open > /dev/null && alias open="xdg-open"
    command -v gio > /dev/null && alias trash="gio trash"
fi

alias week="date +%V"
alias datetime="date -Iseconds"
alias camera="ffplay /dev/video0"
alias feh="feh --scale-down"
alias strace="strace -tr --decode-fds=all --syscall-number -a 120"

