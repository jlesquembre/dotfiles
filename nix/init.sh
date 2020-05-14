#!/usr/bin/env bash

set -e

nixos_conf="/etc/nixos/configuration.nix"
nixpkgs_dir="${HOME}/nixpkgs"

#if [[ ! -e "$nixos_conf" || ( -L "$nixos_conf" &&  ) ]]   ; then
#  echo "Do nothing" # "$nixos_conf" "${nixos_conf}.original"
#fi

if [[ ! -e "$nixpkgs_dir" ]]; then
  echo "git clone git@github.com:jlesquembre/dotfiles.git ${HOME}/dotfiles"
  git clone git@github.com:jlesquembre/dotfiles.git "${HOME}/dotfiles"

  echo "git clone git@github.com:jlesquembre/nixpkgs.git ${nixpkgs_dir}"
  git clone git@github.com:jlesquembre/nixpkgs.git "${nixpkgs_dir}"

  echo "git -C ${nixpkgs_dir} remote add upstream https://github.com/NixOS/nixpkgs.git"
  git -C "${nixpkgs_dir}" remote add upstream https://github.com/NixOS/nixpkgs.git

  echo "git -C ${nixpkgs_dir} remote add channels https://github.com/NixOS/nixpkgs-channels.git"
  git -C "${nixpkgs_dir}" remote add channels https://github.com/NixOS/nixpkgs-channels.git

  echo "git -C ${nixpkgs_dir} fetch --all"
  git -C "${nixpkgs_dir}" fetch --all

  echo ""
  echo ""
  echo "git -C ${nixpkgs_dir} checkout -b local channels/nixos-unstable"
  git -C "${nixpkgs_dir}" checkout -b local channels/nixos-unstable
  echo ""
  echo ""

  ##### SUDO commands
  echo "sudo mv $nixos_conf ${nixos_conf}.original"
  sudo mv $nixos_conf ${nixos_conf}.original
  echo ""

  # echo "sudo ln -s ${HOME}/dotfiles/nix/configuration.nix ${nixos_conf}"
  # sudo ln -s ${HOME}/dotfiles/nix/configuration.nix ${nixos_conf}
  # echo ""

  # echo "sudo ln -s ${nixpkgs_dir} /etc/nixos/nixpkgs"
  # sudo ln -s ${nixpkgs_dir} /etc/nixos/nixpkgs
  # echo ""

  # Channels are used only for command-not-found command
  echo "sudo nix-channel --add https://nixos.org/channels/nixos-unstable"
  sudo nix-channel --add https://nixos.org/channels/nixos-unstable
  echo ""

  ##### Regular user commands
  echo "ln -s ${nixpkgs_dir} ~/.nix-defexpr/nixpkgs"
  ln -s "${nixpkgs_dir}" ~/.nix-defexpr/nixpkgs

  # channels_root -> /nix/var/nix/profiles/per-user/root/channels/
  echo "rm ~/.nix-defexpr/channels_root"
  rm ~/.nix-defexpr/channels_root

fi

echo ""
echo "After it run:"
echo "nixos-rebuild switch --upgrade"
