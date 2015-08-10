#!/bin/bash

declare -A links

links["$HOME/dotfiles/fish"]="$HOME/.config/fish"
links["$HOME/dotfiles/ranger"]="$HOME/.config/ranger"

links["$HOME/dotfiles/fonts"]="$HOME/.fonts"
links["$HOME/dotfiles/i3"]="$HOME/.i3"

links["$HOME/dotfiles/xprofile"]="$HOME/.xprofile"
links["$HOME/dotfiles/gtkrc-2.0"]="$HOME/.gtkrc-2.0"
links["$HOME/dotfiles/irssi"]="$HOME/.irssi"
links["$HOME/dotfiles/weechat"]="$HOME/.weechat"

links["$HOME/dotfiles/gitconfig"]="$HOME/.gitconfig"
links["$HOME/dotfiles/tigrc"]="$HOME/.tigrc"
links["$HOME/dotfiles/pacman"]="$HOME/.config/pacman"

links["$HOME/dotfiles/ipython"]="$HOME/.ipython"

# key   -> target
# value -> link

execute_commands() { #{{{
  for target in "${!links[@]}"
  do
    link=${links[$target]}

    # Check if there is a file with same link name
    if [ -e "$link" ] || [ -L "$link" ]; then
      if [ -L "$link" ]; then
        # It's a symlink
        rm "$link"
      elif [ -d "$link" ]; then
        # It's a directory
        rm -r "$link"
      else
        rm "$link"
      fi
    fi

    ln -s "$target" "$link"

  done
} #}}}

print_commands() { #{{{
  for target in "${!links[@]}"
  do
    link=${links[$target]}
    echo "ln -s $target $link"
  done
} #}}}


echo " 1) Print commands [DEFAULT]"
echo " 2) Execute commands"
echo ""
read -p '> ' OPTION
case "$OPTION" in
  2)
    execute_commands
    ;;
  *)
    print_commands
    ;;
esac
