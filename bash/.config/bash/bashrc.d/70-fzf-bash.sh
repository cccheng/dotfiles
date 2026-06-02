#!/usr/bin/env bash
# shellcheck disable=SC2034

eval "$(fzf --bash 2>/dev/null)"

FZF_DEFAULT_OPTS="--multi --info=right --prompt='» '"
FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind ctrl-b:page-up,ctrl-f:page-down"
FZF_ICEBERG_SOFT="dark,bg:#161822,bg+:#282d43,fg:#c7c9d1,fg+:#f0f1f5,hl:#e2a578,hl+:#e4aa81,info:#6c7189,prompt:#b5bf82,pointer:#b5bf82,marker:#85a0c7,spinner:#89b9c2,header:#6c7189,border:#101218,gutter:#161822"
FZF_ICEBERG_CONTRAST="dark,bg:#161822,bg+:#3d425c,fg:#c7c9d1,fg+:#f0f1f5,hl:#b5bf82,hl+:#b5bf82,info:#6c7189,prompt:#85a0c7,pointer:#b5bf82,marker:#85a0c7,spinner:#89b9c2,header:#69719b,border:#3f455f,gutter:#161822"
FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color='$FZF_ICEBERG_CONTRAST'"
export FZF_DEFAULT_OPTS
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_COMPLETION_TRIGGER="~~"
