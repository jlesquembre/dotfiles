{ pkgs ? import <nixpkgs> {} }:

pkgs.vscode-with-extensions.override {
  # When the extension is already available in the default extensions set.
  vscodeExtensions = with pkgs.vscode-extensions; [
    bbenoist.Nix
  ]
  # Concise version from the vscode market place when not available in the default set.
  ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      publisher = "vscodevim";
      name = "vim";
      version = "0.15.7";
      sha256 = "1bqpwyrd8c242l6mm78qla30y9x74h4v7r9n6yf8a8zwqyr2yv3c";
    }
    {
      publisher = "vscjava";
      name = "vscode-java-pack";
      version = "0.3.0";
      sha256 = "0wzdx87wjcdmalz4izbgbws98w8wkaak3bzqbywlvgvvra7ak2pq";
    }
    # {
    #   publisher = "sdras";
    #   name = "night-owl";
    #   version = "0.4.1";
    #   sha256 = "1m9n2ny321v2z5x8338p45467i1idic5mha7llslkcyji43q4pyx";
    # }
  ];
}
