#!/usr/bin/env bash
# shellcheck disable=SC1091

if [ -s "${CARGO_HOME:-$HOME/.cargo}/env" ]; then
    source "${CARGO_HOME:-$HOME/.cargo}/env"
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

