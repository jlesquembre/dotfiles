# dotfiles

My personal dotfiles

```
# "nixpkgs-overlays=/run/current-system/libkookie/overlays"
# "home-manager=/data/src/nix/home-manager"
# "home-manager-config=/data/src/nix/config/home-manager"

```

## Structure

- `/machines`: Main entry points
- `/overlays`: Custom packages and modificaton to nixpkgs
- `/modules`: System configuration

# Installation

- Clone `nixpkgs` and `home-manager`

- Link NixOS configuration to one of the main entry points:

  ```bash
  sudo ln -s ~/dotfiles/machines/alpha.nix /etc/nixos/configuration.nix
  ```

- Force `nix-env` command to use your cloned `nixpkgs` version

  ```bash
  ln -s ${nixpkgs_dir} ~/.nix-defexpr/nixpkgs

  # channels_root -> /nix/var/nix/profiles/per-user/root/channels/
  rm ~/.nix-defexpr/channels_root
  ```

# NixOS install

Check if there is an user and is on `wheel` group:

```
extraGroups = [ "wheel" ];
```

```
wget http://bit.do/jlnix -O init.sh
bash init.sh
spark deploy main.sus
nix-env -ir all
```
