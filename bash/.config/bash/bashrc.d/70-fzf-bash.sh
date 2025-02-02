#!/usr/bin/env bash
# shellcheck disable=SC2034

eval "$(fzf --bash 2>/dev/null)"

FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
FZF_DEFAULT_OPTS="--multi --color='dark,fg+:bright-green,pointer:bright-cyan' --preview 'less {}'"
FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind ctrl-b:page-up,ctrl-f:page-down"
#FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind tab:down,shift-tab:up"
FZF_COMPLETION_TRIGGER="!!"
