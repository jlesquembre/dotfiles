# dotfiles

My personal dotfiles

## Structure

- `/machines`: Main entry points
- `/overlays`: Custom packages and modificaton to nixpkgs
- `/modules`: System configuration
- `/home-manager`: Home manager configuration
- `/dotfiles`: Configuration files

# Installation

- Clone `nixpkgs` and `home-manager`

- Link NixOS configuration to one of the main entry points:

  ```bash
  sudo ln -s ~/dotfiles/machines/alpha.nix /etc/nixos/configuration.nix
  ```

- Force `nix-env` command to use your cloned `nixpkgs` version

  ```bash
  ln -s ${HOME}/nixpkgs ~/.nix-defexpr/nixpkgs

  # channels_root -> /nix/var/nix/profiles/per-user/root/channels/
  rm ~/.nix-defexpr/channels_root
  ```
