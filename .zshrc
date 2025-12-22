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

if [[ -z "$NVIM" ]]; then
  # Only run this if not in Neovim terminal
  # antidote load ${ZDOTDIR}/.zsh_plugins_asdf.txt
fi

source $(brew --prefix)/opt/spaceship/spaceship.zsh

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh
zinit snippet OMZ::plugins/fzf/fzf.plugin.zsh
zinit snippet OMZ::plugins/python/python.plugin.zsh
zinit snippet OMZ::plugins/podman/podman.plugin.zsh
zinit snippet OMZ::plugins/docker/docker.plugin.zsh
zinit snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zinit snippet OMZ::plugins/zoxide/zoxide.plugin.zsh
zinit snippet OMZ::plugins/eza/eza.plugin.zsh
zinit snippet OMZ::plugins/asdf/asdf.plugin.zsh

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light junegunn/fzf-git.sh
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
zinit ice as"program" pick"bin/git-fuzzy"; zinit light bigH/git-fuzzy


### End of Zinit's installer chunk
