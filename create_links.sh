#!/bin/bash

declare -A links

links["$HOME/dotfiles/fish"]="$HOME/.config/fish"
links["$HOME/dotfiles/ranger"]="$HOME/.config/ranger"

links["$HOME/dotfiles/fonts"]="$HOME/.fonts"
links["$HOME/dotfiles/i3"]="$HOME/.i3"

links["$HOME/dotfiles/xprofile"]="$HOME/.xprofile"
links["$HOME/dotfiles/gtkrc-2.0"]="$HOME/.gtkrc-2.0"

# key   -> target
# value -> link
for target in "${!links[@]}"
do
  link=${links[$i]}

  # Check if there is a file with same link name
  if [ -e "$link" ] || [ -L "$link"]; then
    if [ -d "$link" ]; then
      # It's a directory!
      rmdir "$link"
    else
      rm "$link"
    fi
  fi

  ln -s "$target" "$link"

done
