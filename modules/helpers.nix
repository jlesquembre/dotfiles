{ pkgs ? import <nixpkgs> { } }:
let
  # nix-medley = (import ../../projects/nix-medley { inherit pkgs; });
  nix-medley =
    let
      commit = "2e8b766ab0588e1e6a9d555df59ca03d4d4bcff1";
      src =
        fetchTarball {
          url = "https://github.com/jlesquembre/nix-medley/archive/${commit}.tar.gz";
          sha256 = "1jpay5shg0cnvy78fcwlfw4zfc130cqrry4rznga8cb2rvy0psnw";
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
