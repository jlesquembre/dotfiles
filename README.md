# dotfiles

My personal dotfiles

## Structure

- `/dotfiles`: Configuration files, like `.conf`, `.json` files
- `/home-manager`: Home manager configuration
- `/lib`: Helper functions
- `/nixos`: Nix configuration for `nixos-rebuild` commands

- TODO remove?
- `/overlays`: Custom packages and modificaton to nixpkgs
- `/modules`: System configuration

# Installation

## NixOS

- `sudo nixos-rebuild switch --flake ~/dotfiles`

That commnads assumes that a file with the same name as the current hostname at
`nixos/hosts`. For example, if the hostname is `foo`, the file will be
`/nixos/hosts/foo.nix`. That file is the main entry point for the NixOS
configuration.

We can override the flake hostname with the `#name` syntax, e.g.:
`--flake ~/dotfiles#other-name`

## Home manager

- `home-manager switch --flake ~/dotfiles`

To add some extra custom config for only one host, add a file with that hostname
at `home-manager/hosts`

To build home-manager for a different host use the `#` syntax, but for
home-manager the user name is also required, e.g.:

`home-manager switch --flake ~/dotfiles#user@host`

# Update dependencies

`nix flake lock --update-input`
