# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Pull in bash modules
while read -r f; do
    source "$f";
done < <(find "$HOME/.bashrc.d/" -name "*.sh" | sort)

if [ -r $HOME/.bashrc.d/env-${HOSTNAME,,}.sh ]; then
    source "$HOME/.bashrc.d/env-${HOSTNAME,,}.sh"
fi

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

append_path()
{
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}
append_path "$HOME/.local/bin"
unset -f append_path
export PATH

[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"
[ -s "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && source "$HOME/.nix-profile/etc/profile.d/nix.sh"

# Do something when connected via SSH
if [[ $- =~ i ]] && [[ -n "$SSH_CONNECTION" ]]; then
    true
fi

