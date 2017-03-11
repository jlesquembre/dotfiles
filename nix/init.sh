#!/bin/bash

nixos_conf="/etc/nixos/configuration.nix"
nixpkgs_dir="${HOME}/nixpkgs"

#if [[ ! -e "$nixos_conf" || ( -L "$nixos_conf" &&  ) ]]   ; then
#  echo "Do nothing" # "$nixos_conf" "${nixos_conf}.original"
#fi

if [[ ! -e "$nixpkgs_dir" ]]   ; then
  echo "git clone git://github.com/jlesquembre/nixpkgs.git ${nixpkgs_dir}"
  git clone git://github.com/jlesquembre/nixpkgs.git ${nixpkgs_dir}

  echo "git -C ${nixpkgs_dir} remote add upstream git://github.com/NixOS/nixpkgs.git"
  git -C ${nixpkgs_dir} remote add upstream git://github.com/NixOS/nixpkgs.git

  echo "git -C ${nixpkgs_dir} remote add channels git://github.com/NixOS/nixpkgs-channels.git"
  git -C ${nixpkgs_dir} remote add channels git://github.com/NixOS/nixpkgs-channels.git

  echo "git -C ${nixpkgs_dir} fetch --all"
  git -C ${nixpkgs_dir} fetch --all

  echo ""
  echo ""
  echo "git -C ${nixpkgs_dir} checkout -b local channels/nixos-unstable"
  git -C ${nixpkgs_dir} checkout -b local channels/nixos-unstable
  echo ""
  echo ""
fi

echo "Next steps:"
echo "sudo mv $nixos_conf ${nixos_conf}.original"
echo "sudo ln -s ${HOME}/dotfiles/nix/configuration.nix ${nixos_conf}"
echo "sudo ln -s ${nixpkgs_dir} /etc/nixos/nixpkgs"

# ?????
#echo "ln -s ${nixpkgs_dir} ~/.nix-defexpr/nixpkgs"
#echo "rm ~/.nix-defexpr/channels_root"


echo ""
echo "Create hostname at ${HOME}/dotfiles/nix/hostname"

echo ""
echo "After it run:"
echo "nixos-rebuild switch"
