#!/usr/bin/env bash

bind '"\C-r": "\C-x1\e^\er"'
bind -x '"\C-x1": __fzf_history';

__fzf_history ()
{
    # Capture the selected command from history using fzf
    local selected_cmd
    selected_cmd=$(history | fzf --tac --tiebreak=index | perl -ne 'm/^\s*([0-9]+)\s*(.*)/ and print "$2"')

    # Check if the selected command is different from the last history entry and the last executed command
    if [[ -n $selected_cmd && $selected_cmd != "$(history 1 | sed 's/^[ ]*[0-9]*[ ]*//')" ]]; then
        __ehc "$selected_cmd"
    fi
}

__ehc()
{
    if [[ -n $1 ]]; then
        bind '"\er": redraw-current-line'
        READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${1}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
        READLINE_POINT=$(( READLINE_POINT + ${#1} ))
    else
        bind '"\er":'
    fi
}

