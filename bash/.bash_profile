
# Customize Bash prompt
source "/usr/lib/git-core/git-sh-prompt"
CLEAR="\[\033[m\]"
DARK_YELLOW="\[\033[0;33m\]"
DARK_GREEN="\[\033[0;32m\]"
DARK_CYAN="\[\033[0;36m\]"
DARK_GREY="\[\033[1;30m\]"
YELLOW="\[\033[1;33m\]"
GREEN="\[\033[1;32m\]"
CYAN="\[\033[1;36m\]"
WHITE="\[\033[1;37m\]"
GIT_PS1="$(__git_ps1 ".%s") "
export PS1="${CLEAR}[${CYAN}\u${WHITE}@${DARK_CYAN}\h${CLEAR}]${GREEN}\w${DARK_GREEN}${GIT_PS1}${YELLOW}\\$ ${CLEAR}"
export PS2="${YELLOW}>${CLEAR} "

# Aliases
alias vim='nvim -p'
alias vimdiff='nvim -d'
alias grep='grep --color'
alias rm='rm -i'
alias ls='ls -CF --color'
alias ll='ls -lF'
alias la='ls -lFA'
alias ip='ip -c'


export GPG_TTY="$(tty)"

# Misc
[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"
[ -s "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && source "$HOME/.nix-profile/etc/profile.d/nix.sh"

if type -p starship &>/dev/null; then
    export STARSHIP_CONFIG="$HOME/.conf/starship.toml"
    eval "$(starship init bash)"
fi

