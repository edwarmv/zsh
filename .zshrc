# export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
alias grep="rg"
alias fv=".fvm/flutter_sdk/bin/flutter"
alias vi="nvim"
alias v="nvim"
alias install-kitty-nightly="curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin installer=nightly"
alias lc="lfcd"
alias lg="lazygit"
alias ld="lazydocker"
alias yz="yazi"
alias zj="zellij"

lfcd () {
    tmp="$(mktemp)"
    # `command` is needed in case `lfcd` is aliased to `lf`
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

function yc() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# REF https://github.com/junegunn/fzf-git.sh/pull/46/files
zvm_after_init() {
  zvm_bindkey viins "^P" up-line-or-beginning-search
  zvm_bindkey viins "^N" down-line-or-beginning-search
  zvm_bindkey viins '^R' fzf-history-widget
  zvm_bindkey vicmd '^R' redo
  zvm_bindkey viins '\ec' fzf-cd-widget
  for o in files branches tags remotes hashes stashes lreflogs each_ref worktrees each_ref; do
    eval "zvm_bindkey viins '^g^${o[1]}' fzf-git-$o-widget"
    eval "zvm_bindkey viins '^g${o[1]}' fzf-git-$o-widget"
  done
}
# Set key bindings for zsh-vi-mode normal and visual modes.
zvm_after_lazy_keybindings() {
  for o in files branches tags remotes hashes stashes lreflogs each_ref worktrees each_ref; do
    eval "zvm_bindkey vicmd '^g^${o[1]}' fzf-git-$o-widget"
    eval "zvm_bindkey vicmd '^g${o[1]}' fzf-git-$o-widget"
    eval "zvm_bindkey visual '^g^${o[1]}' fzf-git-$o-widget"
    eval "zvm_bindkey visual '^g${o[1]}' fzf-git-$o-widget"
  done
}

eval "$(/opt/homebrew/bin/brew shellenv)"
. "$HOME/.cargo/env"

# Clone antidote if necessary.
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load

if [[ -z "$NVIM" ]]; then
  # Only run this if not in Neovim terminal
  antidote load ${ZDOTDIR}/.zsh_plugins_asdf.txt
fi

source $(brew --prefix)/opt/spaceship/spaceship.zsh
