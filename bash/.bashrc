#!/usr/bin/env bash
# shellcheck source=/dev/null

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Reload environ for every terminal because:
# - `sudo -s` preserves $HOME but cleans other envvars
# - bash is built with #define SSH_SOURCE_BASHRC (e.g. Debian)
# - systemd rejects envvars which contain \e (ESC)
source "$HOME/.config/bash/bashrc.d/env.sh"

## Interactive options
case $- in
    *i*) ;;
      *) return;;
esac

GPG_TTY="$(tty)"; export GPG_TTY

# Pull in bash modules. 
while read -r f; do
    source "$f";
done < <(find "$HOME/.config/bash/bashrc.d/" -name "*-*.sh" | sort)

# Resolve symlinks for initial working directory
# cd -P . || true

if [ -r "$HOME/.envrc" ]; then
    source "$HOME/.envrc"
fi

