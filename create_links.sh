#!/bin/bash

declare -A links

links["$HOME/dotfiles/fish"]="$HOME/.config/fish"
links["$HOME/dotfiles/ranger"]="$HOME/.config/ranger"

links["$HOME/dotfiles/fonts"]="$HOME/.local/share/fonts"
links["$HOME/dotfiles/i3"]="$HOME/.i3"

links["$HOME/dotfiles/xsession"]="$HOME/.xsession"
links["$HOME/dotfiles/gtkrc-2.0"]="$HOME/.gtkrc-2.0"

links["$HOME/dotfiles/gitconfig"]="$HOME/.gitconfig"
links["$HOME/dotfiles/tigrc"]="$HOME/.tigrc"
links["$HOME/dotfiles/pacman"]="$HOME/.config/pacman"
links["$HOME/dotfiles/chromium-flags.conf"]="$HOME/.config/chromium-flags.conf"
links["$HOME/dotfiles/termite.conf"]="$HOME/.config/termite/config"
links["$HOME/dotfiles/editorconfig.ini"]="$HOME/.editorconfig"
links["$HOME/dotfiles/hyper.js"]="$HOME/.hyper.js"

links["$HOME/dotfiles/nvim"]="$HOME/.config/nvim"

links["$HOME/dotfiles/ipython"]="$HOME/.ipython"
links["$HOME/dotfiles/jupyter"]="$HOME/.jupyter"

mkdir -p $HOME/.config/termite

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
