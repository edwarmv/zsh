export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

for conf in "$ZDOTDIR/config.d/"*.zsh; do
  source "${conf}"
done
unset conf

source $ZDOTDIR/.antidote/antidote.zsh

antidote load

eval "$(starship init zsh)"
