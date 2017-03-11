#!/bin/bash

nixos_conf="/etc/nixos/configuration.nix"

#if [[ ! -e "$nixos_conf" || ( -L "$nixos_conf" &&  ) ]]   ; then
#  echo "Do nothing" # "$nixos_conf" "${nixos_conf}.original"
#fi

echo "Next steps:"

echo "sudo mv $nixos_conf ${nixos_conf}.original"
echo "sudo ln -s ${HOME}/dotfiles/nix/configuration.nix ${nixos_conf}"

echo ""

echo "Create hostname at ${HOME}/dotfiles/nix/hostname"

