#!/usr/bin/env bash
# shellcheck disable=SC2034

set -a

# Less - various options
# -e	Quit at second EOF
# -M	Detailed status/prompt
# -q	Use visual instead of audible bell at EOF
# -Q	Always use visual bell
# -R	Pass through formatting sequences
# -F	Immediately quit if one screen
# -X	Don't use alternate screen
# -z-3	Keep 3 line context when scrolling
LESS="e M q R F X"

# Set colors for less. Borrowed from https://wiki.archlinux.org/title/Color_output_in_console#less
# Source: http://unix.stackexchange.com/a/147
# More info: http://unix.stackexchange.com/a/108840
# LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
# LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
# LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
# LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
# LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
# LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
# LESS_TERMCAP_ue=$'\E[0m'        # reset underline

set +a

# Make less more friendly for non-text input files, see lesspipe(1)
if command -v lesspipe >/dev/null; then
    eval "$(SHELL=/bin/sh lesspipe)"
elif command -v lesspipe.sh >/dev/null; then
    eval "$(SHELL=/bin/sh lesspipe.sh)"
fi

