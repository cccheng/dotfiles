#!/usr/bin/env bash
# shellcheck disable=SC2034

eval "$(fzf --bash 2>/dev/null)"

FZF_DEFAULT_OPTS="--multi --info=right --prompt='» '"
FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind ctrl-b:page-up,ctrl-f:page-down"
FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color='dark,fg:bright-black,current-fg:bright-green,pointer:green,marker:blue'"
export FZF_DEFAULT_OPTS
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_COMPLETION_TRIGGER="~~"
