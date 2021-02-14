with import <nixpkgs> { };
let
  commit = "4a8cb2bd5051cdce7767bc0ea817aedb3896462d";
  sops-nix =
    callPackage
      (fetchTarball {
        url = "https://github.com/Mic92/sops-nix/archive/${commit}.tar.gz";
        sha256 = "0njfm7rkij94h8sj4vi6aqpr74ddj2vxpa71sz7g82p9cy59db60";
      })
      { };
in
pkgs.mkShell {
  buildInputs = [
    blackbox
    coreutils
    curl
    fish
    git
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
