#!/usr/bin/env bash

HISTSIZE="32768"                        # increase Bash history size. Allow 32³ entries; the default is 500.
HISTFILESIZE="${HISTSIZE}"
HISTFILE="${XDG_STATE_HOME:-.local/state}/bash/history"
HISTCONTROL=ignorespace:erasedups       # omit duplicates and commands that begin with a space from history.
#HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
HISTIGNORE="../*/"                      # don't record some commands
HISTTIMEFORMAT="%F %T "                 # use standard ISO 8601 timestamp
                                        # %F equivalent to %Y-%m-%d
                                        # %T equivalent to %H:%M:%S (24-hours format)

