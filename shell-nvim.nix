with import <nixpkgs> { };
let
  vimDir = builtins.toString ./home-manager;
  update-vim-plugins = pkgs.writeShellScriptBin "update-vim-plugins" ''
    ${builtins.toString <nixpkgs>}/pkgs/misc/vim-plugins/update.py -i ${vimDir}/neovim-plugins.txt -o ${vimDir}/neovim-plugins-generated.nix --no-commit
  '';
in
pkgs.mkShell {
  buildInputs = [
    update-vim-plugins
  ];
}
