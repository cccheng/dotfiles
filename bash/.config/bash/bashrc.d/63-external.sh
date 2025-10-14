#!/usr/bin/env bash
# shellcheck disable=SC1091

if [ -s "${XDG_STATE_HOME}/nix/profile/etc/profile.d/nix.sh" ]; then
    source "${XDG_STATE_HOME}/nix/profile/etc/profile.d/nix.sh"
fi

if [ -d "${CARGO_HOME:-$HOME/.cargo}/bin" ]; then
    add_path "${CARGO_HOME:-$HOME/.cargo}/bin"
fi

if command -v mise >/dev/null; then
    eval "$(mise activate bash --shims)"
fi

# Homebrew ruby
if [ -d "/usr/local/opt/ruby/bin" ]; then
    add_path "/usr/local/opt/ruby/bin"
fi

if command -v eza >/dev/null; then
    alias ls="\eza -F --group-directories-first"
    alias ll="\eza -bgHilSF --time-style=long-iso --group-directories-first --icons"
    alias la="\eza -abgHhilSF --git --time-style=long-iso --group-directories-first --icons"
fi

if command -v bat >/dev/null; then
    alias cat="\bat -p --theme=Nord"
fi

