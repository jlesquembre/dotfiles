{ pkgs ? import <nixpkgs> { } }:
let
  # nix-medley = (import ../../projects/nix-medley { inherit pkgs; });
  nix-medley =
    let
      commit = "d6da465e5486152ec1b31f36c2363957a16ebe60";
      src =
        fetchTarball {
          url = "https://github.com/jlesquembre/nix-medley/archive/${commit}.tar.gz";
          sha256 = "0i094n2d0n7w7bgr0r4dmdfwg81xalvy5ar5gfs2rmmcs2q0qlpq";
        };
    in
    (import src { inherit pkgs; });
  ageKeyFile = "/etc/nixos/key.txt";
in
{
  inherit ageKeyFile;

  import-secret = secretPath: (builtins.exec [
    "sh"
    "-c"
    ''SOPS_AGE_KEY_FILE=${ageKeyFile} ${pkgs.sops}/bin/sops -d ${secretPath}''
  ]);
} // nix-medley
