#!/usr/bin/env bash
# shellcheck disable=SC1091

if command -v mise >/dev/null; then
    eval "$(mise activate bash)"
fi

if [ -d "${CARGO_HOME:-$HOME/.cargo}/bin" ]; then
    add_path "${CARGO_HOME:-$HOME/.cargo}/bin"
fi

if [ -s "${rvm_path:-$HOME/.rvm}/scripts/rvm" ]; then
    source "${rvm_path:-$HOME/.rvm}/scripts/rvm"
fi

if [ -s "${XDG_STATE_HOME}/nix/profile/etc/profile.d/nix.sh" ]; then
    source "${XDG_STATE_HOME}/nix/profile/etc/profile.d/nix.sh"
fi

# Homebrew ruby
if [ -d "/usr/local/opt/ruby/bin" ]; then
    add_path "/usr/local/opt/ruby/bin"
fi

if command -v eza >/dev/null; then
    alias ls="\eza -F --group-directories-first"
    alias ll="\eza -bgHilSF --time-style=long-iso --group-directories-first"
    alias la="\eza -abgHilSF --git --time-style=long-iso --group-directories-first"
fi

if command -v lsd >/dev/null; then
    alias lsd="\lsd -AFlig --icon never --group-dirs first --date '+%Y-%m-%d %H:%M'"
fi

if command -v bat >/dev/null; then
    alias cat="\bat -p --theme=Nord"
fi

