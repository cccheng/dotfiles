#!/usr/bin/env bash

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=5

if false && tput setaf 1 &> /dev/null; then
    tput sgr0; # reset colors
    CLEAR="\[$(tput sgr0)\]"
    BOLD="\[$(tput bold)\]"
    # Solarized colors, taken from http://git.io/solarized-colors.
    BLACK="\[$(tput setaf 0)\]"
    RED="\[$(tput setaf 124)\]"
    GREEN="\[$(tput setaf 64)\]"
    YELLOW="\[$(tput setaf 136)\]"
    BLUE="\[$(tput setaf 33)\]"
    VIOLET="\[$(tput setaf 61)\]"
    CYAN="\[$(tput setaf 37)\]"
    WHITE="\[$(tput setaf 15)\]"
else
    CLEAR="\[\e[m\]"
    BOLD=""
    DARK_BLACK="\[\e[0;30m\]"
    DARK_RED="\[\e[0;31m\]"
    DARK_GREEN="\[\e[0;32m\]"
    DARK_YELLOW="\[\e[0;33m\]"
    DARK_BLUE="\[\e[0;34m\]"
    DARK_VIOLET="\[\e[0;35m\]"
    DARK_CYAN="\[\e[0;36m\]"
    DARK_WHITE="\[\e[0;37m\]"
    BLACK="\[\e[1;30m\]"
    RED="\[\e[1;31m\]"
    GREEN="\[\e[1;32m\]"
    YELLOW="\[\e[1;33m\]"
    BLUE="\[\e[1;34m\]"
    VIOLET="\[\e[1;35m\]"
    CYAN="\[\e[1;36m\]"
    WHITE="\[\e[1;37m\]"
fi

## Determine if the terminal supports color
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
else
    color_prompt=no
fi

USER_STYLE="${CYAN}"
HOST_STYLE="${BOLD}${DARK_CYAN}"
GIT_STYLE="${DARK_GREEN}"
SYMBOL_STYLE="${CLEAR}"

# Highlight the user name when logged in as root.
if [ "${USER}" == "root" ]; then
    SYMBOL_STYLE="${RED}"
fi

if [ -f "$XDG_CONFIG_HOME/prompt-green" ]; then
    USER_STYLE="${GREEN}"
    HOST_STYLE="${BOLD}${DARK_GREEN}"
    GIT_STYLE="${DARK_YELLOW}"
elif [ -f "$XDG_CONFIG_HOME/prompt-yellow" ]; then
    USER_STYLE="${YELLOW}"
    HOST_STYLE="${BOLD}${DARK_YELLOW}"
    GIT_STYLE="${GREEN}"
fi

# Highlight the @ symbol when connected via ssh.
if [ "${SSH_TTY}" ]; then
    :
else
    :
fi

## Set the prompt based on color support
if [ -r "/usr/lib/git-core/git-sh-prompt" ]; then
    source "/usr/lib/git-core/git-sh-prompt"            # ubuntu
    GIT_PS1='$(__git_ps1 ".%s") '
elif [ -r "/usr/share/git/completion/git-prompt.sh" ]; then
    source "/usr/share/git/completion/git-prompt.sh"    # archlinux
    GIT_PS1='$(__git_ps1 ".%s") '
fi

if [ "$color_prompt" = yes ]; then
    PS1="${SYMBOL_STYLE}["
    PS1+="${USER_STYLE}\u"        # username
    PS1+="${CLEAR}@"
    PS1+="${HOST_STYLE}\h"   # host
    PS1+="${SYMBOL_STYLE}]"
    PS1+="${GREEN}\w"       # working directory full path
    PS1+="${GIT_STYLE}${GIT_PS1}"
    PS1+="${DARK_YELLOW}\\$ ${CLEAR}"
    PS2="  ${YELLOW}→${CLEAR} ";
else
    PS1="[\u@\h]\w\\$ "
    PS2="→ ";
fi
unset color_prompt

export PS1
export PS2

