#!/usr/bin/env bash
# shellcheck disable=SC2034

# Automatically trim long paths in the prompt (requires Bash 5.x)
PROMPT_DIRTRIM=5

USER_STYLE="\[$(ansi::cyan-intense)\]"
HOST_STYLE="\[$(ansi::cyan)\]"
PATH_STYLE="\[$(ansi::green-intense)\]"
GIT_STYLE="\[$(ansi::green)\]"
SYMBOL_STYLE="\[$(ansi::white)\]"
SIGN_STYLE="\[$(ansi::yellow)\]"

# Highlight the brackets when logged in as root.
if [ "${USER}" = "root" ]; then
    SYMBOL_STYLE="\[$(ansi::magenta-intense)\]"
    SIGN_STYLE="\[$(ansi::magenta-intense)\]"
fi

if [ -f "$XDG_CONFIG_HOME/bash/.prompt-green" ]; then
    USER_STYLE="\[$(ansi::green-intense)\]"
    HOST_STYLE="\[$(ansi::green)\]"
    GIT_STYLE="\[$(ansi::yellow)\]"
elif [ -f "$XDG_CONFIG_HOME/bash/.prompt-yellow" ]; then
    USER_STYLE="\[$(ansi::yellow-intense)\]"
    HOST_STYLE="\[$(ansi::yellow)\]"
    GIT_STYLE="\[$(ansi::green-intense)\]"
fi

# Highlight some symbols when connected via ssh.
if [ "${SSH_TTY}" ]; then
    :
else
    :
fi

# Set the prompt based on color support
GIT_PS1='$(__git_ps1 " %s") '

if ansi::is-ansi-supported; then
    PS1="${SYMBOL_STYLE}["
    PS1+="${USER_STYLE}\u"              # username
    PS1+="${SYMBOL_STYLE}@"
    PS1+="${HOST_STYLE}\h"              # host
    PS1+="${SYMBOL_STYLE}]"
    PS1+="${PATH_STYLE}\w"          # working directory full path
    PS1+="${GIT_STYLE}${GIT_PS1}"
    PS1+="${SIGN_STYLE}\\$\[$(ansi::reset-color)\] "
    PS2="${SIGN_STYLE}  »\[$(ansi::reset-color)\] ";
else
    PS1="[\u@\h]\w \\$ "
    PS2="  » ";
fi
unset USER_STYLE HOST_STYLE PATH_STYLE GIT_STYLE SYMBOL_STYLE SIGN_STYLE

export PS1
export PS2

