#!/usr/bin/env bash

eval $(SHELL=bash; keychain --noask --quiet --eval --agents gpg,ssh)
#eval $(gpg-agent --daemon --enable-ssh-support)

# Load modified map keyboard
setxkbmap -I ~/dotfiles/xkb isodev -print | xkbcomp -w 3 -I$HOME/dotfiles/xkb - $DISPLAY

# Disable PC Speaker Beep
xset -b

if [ "$XDG_CURRENT_DESKTOP" == "i3" ]; then
  export XDG_CURRENT_DESKTOP="KDE"
fi
