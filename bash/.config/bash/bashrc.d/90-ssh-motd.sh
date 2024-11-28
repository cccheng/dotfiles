#!/usr/bin/env bash

# Do something when connected via SSH
# $SSH_CLIENT / $SSH_CONNECTION / $SSH_TTY
if [ "$SHLVL" -eq 1 ] && [ -n "$SSH_CLIENT" ]; then
    hash motd 2>/dev/null && motd
fi


