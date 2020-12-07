{ config, pkgs, lib, ... }:
let
  # nix-freespace = self.callPackage ./extra/nix-freespace.nix { inherit (super); };
  # TODO unify with functions in fish.nix
  # TODO do something like https://github.com/hlissner/dotfiles/blob/master/bin/hey
  nix-freespace = pkgs.writeScriptBin "nix-freespace" ''
    #!${pkgs.bash}/bin/bash
    # Delete everything from this profile that isn't currently needed
    # nix-env --delete-generations old  # --> Not needed (done by nix-collect-garbage)

    # Delete generations older than a week
    nix-collect-garbage --delete-older-than 7d
    sudo nix-collect-garbage --delete-older-than 7d

    # Optimize
    # nix-store --gc --print-dead  # --> Not needed (done by nix-collect-garbage)
    nix-store --optimise
  '';

  # TODO use babashka
  nix-graph = pkgs.writeScriptBin "nix_graph" ''
    #!${pkgs.bash}/bin/bash
    # nix-store -q --graph $(nix-store --realise $(nix-instantiate -A pgpdump)) | dot -Tpdf | zathura -
    # if is a .nix file or a folder with a default.nix file:
    nix-store --query --graph (nix-build --show-trace --no-out-link $@) | ${pkgs.graphviz}/bin/dot -Tx11

    # if not, assume is a package name
    nix-store --query --graph (nix-build "<nixpkgs>" --show-trace --no-out-link -A $@) | ${pkgs.graphviz}/bin/dot -Tx11
  '';
in
{

  home.packages = [
    nix-freespace
    nix-graph
  ];
}
