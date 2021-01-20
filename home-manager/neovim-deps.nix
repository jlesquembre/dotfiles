{ pkgs }:
{
  neovim-nightly = pkgs.neovim-unwrapped.overrideAttrs (oa: {
    version = "master";

    src = pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "d6d4e3d1ae88fd037aadb12a3237fdecfb1c692d";
      sha256 = "1rlc9m8k00awwvgk0zffnsjgcc0w9j01vvnpv5afh2zbh6sh7778";
    };

    buildInputs = oa.buildInputs ++ ([
      pkgs.tree-sitter
    ]);

    cmakeFlags = oa.cmakeFlags ++ [
      "-DUSE_BUNDLED=OFF"
    ];
  });
  formatter-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "formatter-nvim";
    version = "2020-16-12";
    src = pkgs.fetchFromGitHub {
      owner = "mhartington";
      repo = "formatter.nvim";
      rev = "4bbf4c83f55aae4162f46bed98db871bdbf783b3";
      sha256 = "1yjxhlf4k2k04qg25n8kia8w0xfnxicxfcfk767mgzmfz6adn462";
    };
  };

  gitsigns-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "gitsigns-nvim";
    version = "2020-18-12";
    src = pkgs.fetchFromGitHub {
      owner = "lewis6991";
      repo = "gitsigns.nvim";
      rev = "59f7091554378794229bccca1faef6cfcc662024";
      sha256 = "05s2ln800gxw0xk53gf8zsv01hxdznhrqrkprp4iki4k28lay5kd";
    };
  };

  nvim-jdtls = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-jdtls";
    version = "2021-01-10";
    src = pkgs.fetchFromGitHub {
      owner = "mfussenegger";
      repo = "nvim-jdtls";
      rev = "357d0b405235e3dfb0b15450f33ad6d10cbf2122";
      sha256 = "1gd4kjxpb73d6ixxgg4qyzj5alca590whx1i905j3m8j4sjb7vib";
    };
  };
  galaxyline-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "galaxyline-nvim";
    version = "2020-12-14";
    src = pkgs.fetchFromGitHub {
      owner = "glepnir";
      repo = "galaxyline.nvim";
      rev = "64d6b8e31459057ba4f9b03a977fce0d2cc3d748";
      sha256 = "1w5cggvxvmnm3zparnsgb3iz1pkw7d8bwvflcxaxg4pilgsniqsa";
    };
    meta.homepage = "https://github.com/glepnir/galaxyline.nvim/";
  };
  nvim-bufferline-lua = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-bufferline-lua";
    version = "2020-12-31";
    src = pkgs.fetchFromGitHub {
      owner = "akinsho";
      repo = "nvim-bufferline.lua";
      rev = "a872f34fa53cea9a37f608b17804114add4df049";
      sha256 = "158j0qi0m9nsyv8369drd3b2bscayss57cssc5xc41mhv9393j9v";
    };
  };

  nvim-toggleterm-lua = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-toggleterm-lua";
    version = "2021-01-03";
    src = pkgs.fetchFromGitHub {
      owner = "akinsho";
      repo = "nvim-toggleterm.lua";
      rev = "7b1ccaf320beefe3e54a3d6b5808aaad37376694";
      sha256 = "0jk4vja6x8jf9qapbldy78zmamnl5rx711v5a65vffb0zgg7s3jx";
    };
  };

  ######
  ######
  ######
  ######
  ######
  ######


  fern-nerdfont = pkgs.vimUtils.buildVimPlugin {
    name = "fern-renderer-nerdfont.vim";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "fern-renderer-nerdfont.vim";
      rev = "master";
      sha256 = "196rmfrzb9rb4cmkf9x41vmjdnn9v2vc99ynrgnyaq7ciyrgy13w";
    };
  };

  nerdfont = pkgs.vimUtils.buildVimPlugin {
    name = "nerdfont.vim";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "nerdfont.vim";
      rev = "v1.0.0";
      sha256 = "196rmfrzb9rb4cmkf9x41vmjdnn9v2vc99ynrgnyaq7ciyrgy13w";
    };
  };

  visual-star = pkgs.vimUtils.buildVimPlugin {
    name = "visual-star";
    src = pkgs.fetchFromGitHub {
      owner = "bronson";
      repo = "vim-visual-star-search";
      rev = "master";
      sha256 = "1fmfsalmj5qam439rv5wm11az53ql9h5ikg0drx3kp8d5b6fcr9c";
    };
  };

  transpose-words = pkgs.vimUtils.buildVimPlugin {
    name = "transpose-words";
    src = pkgs.fetchFromGitHub {
      owner = "vim-scripts";
      repo = "transpose-words";
      rev = "1.1";
      sha256 = "1ijc1z7jf7cil1k8i27k2208i7avimzrl6vm7mzws68mdz3bqhmg";
    };
  };

  capslock = pkgs.vimUtils.buildVimPlugin {
    name = "capslock";
    src = pkgs.fetchFromGitHub {
      owner = "tpope";
      repo = "vim-capslock";
      rev = "master";
      sha256 = "1c2fr8s9im3vxrszsrzm6wvad6disbdslmq6lqdp4603ialy4kja";
    };
  };

  vim-alias = pkgs.vimUtils.buildVimPlugin {
    name = "vim-alias";
    src = pkgs.fetchFromGitHub {
      owner = "Konfekt";
      repo = "vim-alias";
      rev = "master";
      sha256 = "1bcp3dr312d1zsicqg1lp9gqd5hkiiixvfd6qk60aa4a6lwa8cjg";
    };
  };

  vim-dotenv = pkgs.vimUtils.buildVimPlugin {
    name = "vim-dotenv";
    src = pkgs.fetchFromGitHub {
      owner = "tpope";
      repo = "vim-dotenv";
      rev = "master";
      sha256 = "130g0s6zzl228fcbc80d55v1wxw75hlyyvz42cwbipij5cl7vd17";
    };
  };

  vim-flog = pkgs.vimUtils.buildVimPlugin {
    name = "vim-flog";
    src = pkgs.fetchFromGitHub {
      owner = "rbong";
      repo = "vim-flog";
      rev = "master";
      sha256 = "1mp4pb3ffwi8fz4lwx1jipxpx2lii0pmaqikf5n5x2xw96sm3n2b";
    };
  };

  pgsql-vim = pkgs.vimUtils.buildVimPlugin {
    name = "pgsql-vim";
    src = pkgs.fetchFromGitHub {
      owner = "lifepillar";
      repo = "pgsql.vim";
      rev = "postgresql12.3";
      sha256 = "0mvr3pp980mnvmb8xqq2hm44s477mr2gf1h01yndw83kjj541vhl";
    };
  };

  vim-git = pkgs.vimUtils.buildVimPlugin {
    name = "vim-git";
    src = pkgs.fetchFromGitHub {
      owner = "tpope";
      repo = "vim-git";
      rev = "master";
      sha256 = "1061l9igdywfbqgwpf2f25yby78phb512hjbyzvqz5l1p7dw1xyd";
    };
  };

  vim-mustache-handlebars = pkgs.vimUtils.buildVimPlugin {
    name = "vim-mustache-handlebars";
    src = pkgs.fetchFromGitHub {
      owner = "mustache";
      repo = "vim-mustache-handlebars";
      rev = "master";
      sha256 = "0mhgdah2fg9nvwlvfr3s091f6k3y3x9mk520yv250yg7ywg43hb5";
    };
  };

  nginx-vim = pkgs.vimUtils.buildVimPlugin {
    name = "nginx-vim";
    src = pkgs.fetchFromGitHub {
      owner = "chr4";
      repo = "nginx.vim";
      rev = "master";
      sha256 = "02bsjg7imfdcim6i80b80yda1b7dc4wsrq1fhpyy9y151cskbzh9";
    };
  };

  vim-systemd-syntax = pkgs.vimUtils.buildVimPlugin {
    name = "vim-systemd-syntax";
    src = pkgs.fetchFromGitHub {
      owner = "Matt-Deacalion";
      repo = "vim-systemd-syntax";
      rev = "master";
      sha256 = "0fqk5fxrdf8nazic244ia4bi75midmpj896vdkdmxnv563lnhkcy";
    };
  };

  # janet-vim = pkgs.vimUtils.buildVimPlugin {
  #   name = "janet-vim";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "janet-lang";
  #     repo = "janet.vim";
  #     rev = "master";
  #     sha256 = "1671vyj1s0diwgzm9r4jybp0gj92jrha5a3vcndamk4ghzpkxl6a";
  #   };
  # };

  # vim-hexokinase = pkgs.vimUtils.buildVimPlugin {
  #   name = "vim-hexokinase";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "RRethy";
  #     repo = "vim-hexokinase";
  #     rev = "master";
  #     sha256 = "1mn5l5pfngb8qarmhxjfsgw3syqn1q484fmg9c9dydf5ld5qfzv9";
  #   };
  # };

  rainbow_parentheses-vim = pkgs.vimUtils.buildVimPlugin {
    name = "rainbow_parentheses-vim";
    src = pkgs.fetchFromGitHub {
      owner = "junegunn";
      repo = "rainbow_parentheses.vim";
      rev = "master";
      sha256 = "0izbjq6qbia013vmd84rdwjmwagln948jh9labhly0asnhqyrkb8";
    };
  };

  vim-qf = pkgs.vimUtils.buildVimPlugin {
    name = "vim-qf";
    src = pkgs.fetchFromGitHub {
      owner = "romainl";
      repo = "vim-qf";
      rev = "master";
      sha256 = "1pr2v4jlf8nsf7l3w0zi4c4nfdynbx2i8jsykgknrjfbp729b1cy";
    };
  };
}
