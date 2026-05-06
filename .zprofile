export GOPATH=$HOME/go
# use the updadated version of grep from homebrew
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
export PATH=":$HOME/.local/bin:$PATH"
export PATH=":$GOPATH/bin:$PATH"
export PATH=":$HOME/.dotnet/tools:$PATH"
export PATH=":/usr/share/git/diff-highlight:$PATH"
export PATH=":$HOME/.pub-cache/bin:$PATH"
export PATH=":$HOME/fvm/default/bin:$PATH"
# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/edwar/.lmstudio/bin"
# End of LM Studio CLI section
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export TERMINFO_DIRS=":$HOME/.local/share/terminfo"
export EXA_COLORS="reset"
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export XDG_CONFIG_HOME=$HOME/.config
export ZSH_TMUX_CONFIG=$HOME/.config/tmux/tmux.conf
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export NNN_FCOLORS="000004000000000200000000"
export FZF_DEFAULT_OPTS="
  --bind=alt-j:preview-down,alt-k:preview-up,alt-d:preview-page-down,alt-u:preview-page-up,change:first,alt-a:select-all,alt-A:deselect-all,alt-p:toggle-preview \
  --preview-window=noborder \
  --layout=reverse \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --color=16 \
"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8,bold,underline"
export ZVM_VI_HIGHLIGHT_FOREGROUND=7
export ZVM_VI_HIGHLIGHT_BACKGROUND=8
export ZVM_READKEY_ENGINE=zle
export ZVM_KEYTIMEOUT=0.5
export ZOXIDE_CMD_OVERRIDE='cd'


export VISUAL="nvim"
export EDITOR="nvim"
