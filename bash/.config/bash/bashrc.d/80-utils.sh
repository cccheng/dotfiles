#!/usr/bin/env bash

# Print each PATH entry on a separate line
path()
{
    echo -e "${PATH//:/\\n}"
}

# notify about the status of last command
notify() {
    status=$([ $? -eq 0 ] && echo "Completed" || echo "Failed")
    last_cmd=$(fc -nl -1 | xargs | sed -e "s/;\s*notify$//")
    notify-send --urgency=normal "$status: $last_cmd"
}

