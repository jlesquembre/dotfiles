{ pkgs ? import <nixpkgs> { } }:
let
  nix-medley = (import ../../projects/nix-medley { inherit pkgs; });
in
{
  import-secret = secretPath: (builtins.exec [
    "${pkgs.sops}/bin/sops"
    "-d"
    secretPath
  ]);
} // nix-medley
