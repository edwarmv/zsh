export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

for conf in "$ZDOTDIR/config.d/"*.zsh; do
  source "${conf}"
done
unset conf

source $ZDOTDIR/.antidote/antidote.zsh

antidote load

if [[ -z "$NVIM" ]]; then
  # Only run this if not in Neovim terminal
  antidote load ${ZDOTDIR}/.zsh_plugins_asdf.txt
fi

eval "$(starship init zsh)"
