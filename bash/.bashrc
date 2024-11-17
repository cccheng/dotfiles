# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# Reload environ for every terminal because:
# - `sudo -s` preserves $HOME but cleans other envvars
# - bash is built with #define SSH_SOURCE_BASHRC (e.g. Debian)
# - systemd rejects envvars which contain \e (ESC)
source "${XDG_CONFIG_HOME:-$HOME/.config}/bash/bashrc.d/env.sh"

export GPG_TTY="$(tty)"

if [ -n "$SSH_CLIENT" ]; then
    SELF=${SSH_CLIENT%% *}
fi

### Interactive options

case $- in
    *i*) ;;
      *) return;;
esac

#set +h                                  # Disable command hashing
shopt -s checkhash                      # Re-check $PATH on hash failure
#set -o physical                         # resolve symlinks when 'cd'ing
shopt -s autocd 2>/dev/null             # assume 'cd' when trying to exec a directory
shopt -s cdspell                        # autocorrect typos in path names when using `cd`
shopt -s dirspell 2>/dev/null           # autocorrect on directory names to match a glob.
shopt -s checkjobs 2> /dev/null         # print job status on exit
shopt -s checkwinsize                   # update $ROWS/$COLUMNS after command
shopt -s extglob                        # @(…) +(…) etc. globs
shopt -s globstar 2>/dev/null           # the ** glob, recursive globbing, e.g. `echo **/*.txt`
shopt -s nocaseglob                     # case-insensitive globbing (used in pathname expansion)

shopt -u hostcomplete                   # no special treatment for Tab at @
shopt -s no_empty_cmd_completion

set +o histexpand                       # disable !history expansion
shopt -s cmdhist                        # store multi-line commands as single history entry
shopt -s histappend                     # append to $HISTFILE on exit
shopt -s histreedit                     # allow re-editing failed history subst

HISTSIZE="32768"                        # increase Bash history size. Allow 32³ entries; the default is 500.
HISTFILESIZE="${HISTSIZE}"
HISTFILE="${XDG_DATA_HOME:-.local/share}/bash/history"
HISTCONTROL=ignorespace:erasedups       # omit duplicates and commands that begin with a space from history.
#HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
HISTIGNORE="../*/"                      # don't record some commands
HISTTIMEFORMAT="%F %T "                 # use standard ISO 8601 timestamp
                                        # %F equivalent to %Y-%m-%d
                                        # %T equivalent to %H:%M:%S (24-hours format)

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Pull in bash modules
while read -r f; do
    source "$f";
done < <(find "$XDG_CONFIG_HOME/bash/bashrc.d/" -name "*-*.sh" | sort)

if [ -r "$XDG_CONFIG_HOME/bash/bashrc.d/env-${HOSTNAME,,}.sh" ]; then
    source "$XDG_CONFIG_HOME/bash/bashrc.d/env-${HOSTNAME,,}.sh"
fi

[ -s "${CARGO_HOME:-$HOME/.cargo}/env" ] && source "${CARGO_HOME:-$HOME/.cargo}/env"
[ -s "${rvm_path:-$HOME/.rvm}/scripts/rvm" ] && source "${rvm_path:-$HOME/.rvm}/scripts/rvm"
[ -s "${XDG_STATE_HOME}/nix/profile/etc/profile.d/nix.sh" ] && source "${XDG_STATE_HOME}/nix/profile/etc/profile.d/nix.sh"

# Resolve symlinks for initial working directory
cd -P .

# Do something when connected via SSH
if [ -n "$SSH_CONNECTION" ]; then
    true
fi

