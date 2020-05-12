{ pkgs ? import <nixpkgs> { } }:

pkgs.vscode-with-extensions.override {
  # When the extension is already available in the default extensions set.
  vscodeExtensions = with pkgs.vscode-extensions; [
    bbenoist.Nix
    ms-azuretools.vscode-docker
    ms-kubernetes-tools.vscode-kubernetes-tools
    ms-vscode.Go
    ms-vscode-remote.remote-ssh
    ms-python.python
    redhat.vscode-yaml
    vscodevim.vim
  ]
  # Concise version from the vscode market place when not available in the default set.
  ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      publisher = "MS-vsliveshare";
      name = "vsliveshare-pack";
      version = "0.3.4";
      sha256 = "0svijjggycnw9iy7ziiixmcf83p45q0nzvhm0pvcm982hpi4dkra";
    }
    {
      publisher = "vscjava";
      name = "vscode-java-pack";
      version = "0.9.0";
      sha256 = "0yvbxlflz5gx2i16kjh4mg64z8138rh0ck8n986hf66gjr7vv89m";
    }
    # {
    #   publisher = "sdras";
    #   name = "night-owl";
    #   version = "0.4.1";
    #   sha256 = "1m9n2ny321v2z5x8338p45467i1idic5mha7llslkcyji43q4pyx";
    # }
  ];
}
