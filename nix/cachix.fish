#!/usr/bin/env fish

cd /tmp
set -l packages nerdfonts purescript psc-package libreoffice-fresh neovim cdrtools texlive.combined.scheme-full

for package in $packages
  nix-build "<nixpkgs>" -A $package | cachix push jl
end

nix-build ~/dotfiles/nix/emacs.nix | cachix push jl
nix-build ~/dotfiles/nix/vscode.nix | cachix push jl
