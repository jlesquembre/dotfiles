with import <nixpkgs> { };
pkgs.mkShell {
  buildInputs = [
    coreutils
    curl
    fish
    imagemagick
    paperkey
    qrencode
    zbar
  ];
}
