# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zstyle ':plugin:ez-compinit' 'compstyle' 'ohmy'

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

# Bind M-enter
bindkey '^[^M' autosuggest-execute

zstyle ':omz:plugins:eza' 'git-status' yes
zstyle ':omz:plugins:eza' 'icons' yes
zstyle ':omz:plugins:eza' 'hyperlink' yes
zstyle ':omz:update' mode disabled

eval "$(/opt/homebrew/bin/brew shellenv)"
. "$HOME/.cargo/env"

# Clone antidote if necessary.
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
