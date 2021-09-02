{ pkgs ? import <nixpkgs> { } }:
let
  # nix-medley = (import ../../projects/nix-medley { inherit pkgs; });
  nix-medley =
    let
      commit = "342e8521009b7ec814a68bdde3008561029915f6";
      src =
        fetchTarball {
          url = "https://github.com/jlesquembre/nix-medley/archive/${commit}.tar.gz";
          sha256 = "05m6dj3rj8j8qh8jn8hh0j7sh8x56gb8my450cc87fxr3gidwkcg";
        };
    in
    (import src { inherit pkgs; });
in
{
  import-secret = secretPath: (builtins.exec [
    "${pkgs.sops}/bin/sops"
    "-d"
    secretPath
  ]);
} // nix-medley
