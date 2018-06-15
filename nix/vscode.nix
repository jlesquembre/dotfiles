{ pkgs ? import <nixpkgs> {} }:

pkgs.vscode-with-extensions.override {
  # When the extension is already available in the default extensions set.
  vscodeExtensions = with pkgs.vscode-extensions; [
    bbenoist.Nix
  ]
  # Concise version from the vscode market place when not available in the default set.
  ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vim";
      publisher = "vscodevim";
      version = "0.12.0";
      sha256 = "1m9n2ny321v2z5x8338p45467i1idic5mha7llslkcyji43q4pyx";
    }
  ];
}
