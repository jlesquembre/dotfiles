{ pkgs }:
{
  neovim-nightly = pkgs.neovim-unwrapped.overrideAttrs (oa: {
    version = "master";

    src = pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "adbf2dd86b8c7d898843bdf47b89b423f62bee4b";
      sha256 = "10i7mm31vhjddl0s1pjrdcnhyal5la2wa47wscsrx81kn5ili4kc";
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
      rev = "6433129ce42257e20e6518a0c73ee7636b5a8b3d";
      sha256 = "16sjfmr4hldl1mh923s539aii1hkl9qwlxim548vzshxk0r26dd0";
    };
  };

  nvim-jdtls = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-jdtls";
    version = "2020-18-23";
    src = pkgs.fetchFromGitHub {
      owner = "mfussenegger";
      repo = "nvim-jdtls";
      rev = "da0d007798e24b744f0500148b7d5cb003b10c2a";
      sha256 = "0addxkyvwgadkyn2wzfwx3h3yv6k9jhshd0q908zvif27irinq99";
    };
  };
  galaxyline-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "galaxyline-nvim";
    version = "2020-12-14";
    src = pkgs.fetchFromGitHub {
      owner = "glepnir";
      repo = "galaxyline.nvim";
      rev = "528bb65b00f9ef5081cb524638b3337c4e5f26b5";
      sha256 = "069ksz4nfhlr5zlkpawh1yak4yk3vc2cd9mgy5f0r6in3wh0iypc";
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


  fern-vim = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "fern-vim";
    version = "1.28.6";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "fern.vim";
      rev = "v${version}";
      sha256 = "0hdk7v4ag763lwr2gc2vcryhq8nhy0fp52vmb0ws203h4nkkilaf";
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

  fennel-vim = pkgs.vimUtils.buildVimPlugin {
    name = "fennel-vim";
    src = pkgs.fetchFromGitHub {
      owner = "bakpakin";
      repo = "fennel.vim";
      rev = "master";
      sha256 = "0wpqgylpq45w1cfq63cch7ky2qs9rc052nhh8dhgsfsq8v26233r";
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

  vim-gnupg = pkgs.vimUtils.buildVimPlugin {
    name = "vim-gnupg";
    src = pkgs.fetchFromGitHub {
      owner = "jamessan";
      repo = "vim-gnupg";
      rev = "master";
      sha256 = "0y0g3br54sj0h8s6ashny2km2260qw8psqxq00jn0l2chjwsi0d9";
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
