#!/bin/bash

eval $(SHELL=/bin/bash; keychain --noask --quiet --eval --agents gpg,ssh)
#eval $(gpg-agent --daemon --enable-ssh-support)

xrdb $HOME/dotfiles/xresources

# Load modified map keyboard
setxkbmap -I ~/dotfiles/xkb isodev -print | xkbcomp -I$HOME/dotfiles/xkb - $DISPLAY

# Disable PC Speaker Beep
xset -b
