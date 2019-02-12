#!/usr/bin/env fish

cd /tmp
set -l packages nerdfonts neovim cdrtools texlive.combined.scheme-full # graalvm8 purescript psc-package libreoffice-fresh

for package in $packages
  nix-build "<nixpkgs>" -A $package | cachix push jl
end

nix-build ~/dotfiles/nix/emacs.nix | cachix push jl
nix-build ~/dotfiles/nix/vscode.nix | cachix push jl
