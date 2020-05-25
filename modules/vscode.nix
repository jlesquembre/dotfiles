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
      publisher = "MS-vsliveshare";
      name = "vsliveshare";
      version = "1.0.2236";
      sha256 = "19wxkayf503ingxqnhmy6lb7smwjd2ysd2vg7vayfpd5g3kc0bq8";
    }
    {
      publisher = "MS-vsliveshare";
      name = "vsliveshare-audio";
      version = "0.1.85";
      sha256 = "0ibhfiimiv6xxri1lw13b5i8vfnnwnjhfm4p5z9aa5yxxcx6rch1";
    }
    {
      publisher = "vscjava";
      name = "vscode-java-pack";
      version = "0.9.0";
      sha256 = "0yvbxlflz5gx2i16kjh4mg64z8138rh0ck8n986hf66gjr7vv89m";
    }
    {
      publisher = "ms-vscode-remote";
      name = "remote-containers";
      version = "0.117.1";
      sha256 = "0kq3wfwxjnbhbq1ssj7h704gvv1rr0vkv7aj8gimnkj50jw87ryd";
    }
    # {
    #   publisher = "sdras";
    #   name = "night-owl";
    #   version = "0.4.1";
    #   sha256 = "1m9n2ny321v2z5x8338p45467i1idic5mha7llslkcyji43q4pyx";
    # }
  ];
}
