# This file has been generated by ./pkgs/misc/vim-plugins/update.py. Do not edit!
{ lib, buildVimPluginFrom2Nix, fetchFromGitHub, fetchgit }:

final: prev:
{
  baleia-nvim = buildVimPluginFrom2Nix {
    pname = "baleia.nvim";
    version = "2022-05-02";
    src = fetchFromGitHub {
      owner = "m00qek";
      repo = "baleia.nvim";
      rev = "f02674970cb05297158c65e872b41a2b3609991a";
      sha256 = "1ar1akw10wbbpln0b4gqarp6p6a73cmf8b887fmlh186p9fdqhid";
      fetchSubmodules = true;
    };
    meta.homepage = "https://github.com/m00qek/baleia.nvim/";
  };

  nterm-nvim = buildVimPluginFrom2Nix {
    pname = "nterm.nvim";
    version = "2022-05-10";
    src = fetchFromGitHub {
      owner = "jlesquembre";
      repo = "nterm.nvim";
      rev = "cd7b7035d09144ee4ea49244bf5cb8ed68e499f8";
      hash = "sha256-9RmBC8NBwZTzIgKHYGrLk9V2wzjPCgNeVVOeH9oAbzM=";
    };
    meta.homepage = "https://github.com/jlesquembre/nterm.nvim/";
  };

}
