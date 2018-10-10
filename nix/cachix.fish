#!/usr/bin/env fish

cd /tmp
set -l packages nerdfonts libreoffice-fresh neovim cdrtools texlive.combined.scheme-full graalvm8 # purescript psc-package

for package in $packages
  nix-build "<nixpkgs>" -A $package | cachix push jl
end

nix-build ~/dotfiles/nix/emacs.nix | cachix push jl
nix-build ~/dotfiles/nix/vscode.nix | cachix push jl
