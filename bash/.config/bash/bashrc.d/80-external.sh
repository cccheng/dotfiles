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

