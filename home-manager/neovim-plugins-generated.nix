# This file has been generated by ./pkgs/misc/vim-plugins/update.py. Do not edit!
{ lib, buildVimPluginFrom2Nix, fetchFromGitHub }:

final: prev:
{
  cmp-conjure = buildVimPluginFrom2Nix {
    pname = "cmp-conjure";
    version = "2021-08-29";
    src = fetchFromGitHub {
      owner = "PaterJason";
      repo = "cmp-conjure";
      rev = "4c2a2233de7d2c8ccbf8652b4c741921498ceaec";
      sha256 = "1ivrag7gch7mc72rim939z5gh7v532j29hgiy0pxgw3m6lvxdhwq";
    };
    meta.homepage = "https://github.com/PaterJason/cmp-conjure/";
  };

  cmp-nvim-lsp = buildVimPluginFrom2Nix {
    pname = "cmp-nvim-lsp";
    version = "2021-08-26";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp";
      rev = "9af212372c41e94d55603dea8ad9700f6c31573d";
      sha256 = "1r460l4rr5g94zpsknlxb3jxvbznd37f8zsqphapzb12fmxbs814";
    };
    meta.homepage = "https://github.com/hrsh7th/cmp-nvim-lsp/";
  };

  nterm-nvim = buildVimPluginFrom2Nix {
    pname = "nterm-nvim";
    version = "2021-08-24";
    src = fetchFromGitHub {
      owner = "jlesquembre";
      repo = "nterm.nvim";
      rev = "bb612046c7775c6986e706b8ab31057ed8ca19b2";
      sha256 = "1r50z8c3jjx1ysazih298ni2iikblmj48gxh3k9p722kngfdsxjg";
    };
    meta.homepage = "https://github.com/jlesquembre/nterm.nvim/";
  };

  nvim-cmp = buildVimPluginFrom2Nix {
    pname = "nvim-cmp";
    version = "2021-09-03";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "nvim-cmp";
      rev = "6cc8b82267f597c3905e4328624a0fa5ed36152f";
      sha256 = "01r3fx80pld5a473shpj5nnhhv5mbhifvijz8j2yhvszdlx86lpr";
    };
    meta.homepage = "https://github.com/hrsh7th/nvim-cmp/";
  };

  telescope-nvim = buildVimPluginFrom2Nix {
    pname = "telescope-nvim";
    version = "2021-09-02";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope.nvim";
      rev = "ac42f0c26cb417b76046a394c1b3163d346e9107";
      sha256 = "1qzc04xlrkssgvrmciddbykcczklqzhh8fnkr0pf6xrll0vvm1fv";
    };
    meta.homepage = "https://github.com/nvim-telescope/telescope.nvim/";
  };

}
