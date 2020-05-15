# https://nixos.wiki/wiki/Overlays#Using_nixpkgs.overlays_from_configuration.nix_as_.3Cnixpkgs-overlays.3E_in_your_NIX_PATH
# https://gitlab.com/samueldr/nixos-configuration/-/blob/master/modules/overlays-compat/overlays.nix

self: super:

with super.lib;
let
  # Using the nixos plumbing that's used to evaluate the config...
  eval = import <nixpkgs/nixos/lib/eval-config.nix>;
  # Evaluate the config,
  paths = (eval { modules = [ (import <nixos-config>) ]; })
  # then get the `nixpkgs.overlays` option.
  .config.nixpkgs.overlays
  ;
in
foldl' (flip extends) (_: super) paths self
