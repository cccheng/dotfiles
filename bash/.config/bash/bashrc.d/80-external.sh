#!/usr/bin/env bash
# shellcheck disable=SC1091

if [ -d "${CARGO_HOME:-$HOME/.cargo}/bin" ]; then
    add-path "${CARGO_HOME:-$HOME/.cargo}/bin"
fi

if [ -s "${rvm_path:-$HOME/.rvm}/scripts/rvm" ]; then 
    source "${rvm_path:-$HOME/.rvm}/scripts/rvm"
fi

if [ -s "${XDG_STATE_HOME}/nix/profile/etc/profile.d/nix.sh" ]; then
    source "${XDG_STATE_HOME}/nix/profile/etc/profile.d/nix.sh"
fi

# Homebrew ruby
if [ -d "/usr/local/opt/ruby/bin" ]; then
    add-path "/usr/local/opt/ruby/bin"
fi

if type eza &>/dev/null; then
    alias ls="\eza -F --group-directories-first"
    alias ll="\eza -gHilSF --time-style=long-iso --group-directories-first"
    alias la="\eza -agHilSF --git --time-style=long-iso --group-directories-first"
fi

if type lsd &>/dev/null; then
    alias lsd="\lsd -AFlig --icon never --group-dirs first --date '+%Y-%m-%d %H:%M'"
fi

if type bat &>/dev/null; then
    alias cat="\bat -p --theme=Nord"
fi

