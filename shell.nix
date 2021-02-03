with import <nixpkgs> { };
let
  commit = "4a8cb2bd5051cdce7767bc0ea817aedb3896462d";
  sops-nix =
    callPackage
      (fetchTarball {
        url = "https://github.com/Mic92/sops-nix/archive/${commit}.tar.gz";
        sha256 = "1x0qnxgjlcg35m81nfr17qqx3fdrlc5s9hrz68498isc8132d3p6";
      })
      { };
in
pkgs.mkShell {
  buildInputs = [
    blackbox
    coreutils
    curl
    fish
    imagemagick
    nixUnstable
    paperkey
    pass
    qrencode
    sops
    zbar

    sops-nix.ssh-to-pgp
  ];
  NIX_USER_CONF_FILES = writeText "nix.conf" ''
    experimental-features = nix-command flakes ca-references
    ## below allows the use of builtins.exec - for secrets decryption
    allow-unsafe-native-code-during-evaluation = true
  '';
}
