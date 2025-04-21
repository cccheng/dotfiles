#!/usr/bin/env bash

# SPINNER="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
# SPINNER="⣾⣽⣻⢿⡿⣟⣯⣷"
SPINNER="⣷⣯⣟⡿⢿⣻⣽⣾"

stderr::disable()
{
    exec 3>&2           # save stderr
    exec 2>/dev/null
}

stderr::enable()
{
    exec 2>&3           # restore stderr
    exec 3>&-           # close temp fd
}

cmd::run() # $1: message, $@ command
{
    local idx=0 msg="$1" pid

    shift; [ $# -eq 0 ] && {
        echo "$(ansi::green)» $(ansi::reset-color)$msg"
        return
    }

    set +m
    ansi::hide-cursor

    # Trick to suppress coproc job control message while keeping it in parent shell
    stderr::disable
    coproc "$@"
    pid="$COPROC_PID"
    stderr::enable

    trap 'ansi::show-cursor; ansi::reset-color; set -m; kill "$pid" 2>/dev/null; return' SIGINT SIGTERM
    ansi::save-cursor
    while kill -0 "$pid" 2>/dev/null; do
        ansi::restore-cursor
        echo -n "$(ansi::cyan)${SPINNER:$((idx++ % ${#SPINNER})):1} "
        echo -ne "$(ansi::white-intense)$msg"
        sleep 0.10
    done

    ansi::restore-cursor
    ansi::show-cursor
    set -m

    if wait "$pid"; then
        echo "$(ansi::green)» $(ansi::white-intense)$msg"
        ansi::reset-color
        true
    else
        echo "$(ansi::red)» $(ansi::white-intense)$msg"
        ansi::reset-color
        false
    fi
}

