{ pkgs }:
{

  # TODO bundle it with jdt-ls?
  java-debug = pkgs.fetchMavenArtifact
    {
      groupId = "com.microsoft.java";
      artifactId = "com.microsoft.java.debug.plugin";
      version = "0.30.0";
      sha256 = "0xz33p397g4pw6y3ydb9yafh2vnws3ym0nljr3369k47gq0w02v5";
    };

  java-debug-p = pkgs.fetchMavenArtifact
    {
      groupId = "com.microsoft.java";
      artifactId = "java.debug.parent";
      version = "0.30.0";
      sha256 = "1111111111111111111111111111111111111111111111111111";
    };

  neovim-nightly = pkgs.neovim-unwrapped.overrideAttrs (oa: {
    version = "master";

    src = pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "0450e155d48cb2d8a73358e193931d8966a9d2e0";
      sha256 = "0nwxjyk3r98jld67cw535z7bhywjk7l59aj1v7jwk9ahv9qxznri";
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

  nvim-jdtls = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-jdtls";
    version = "2021-02-22";
    src = pkgs.fetchFromGitHub {
      owner = "mfussenegger";
      repo = "nvim-jdtls";
      rev = "58bf37014d1c1c6006bbffeca05839797d701671";
      sha256 = "0wyn66qg6likav566fgglb48m08bw49zbqcra9wmqxdw7azxh4f5";
    };
  };

  nvim-dap = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-dap";
    version = "2021-02-22";
    src = pkgs.fetchFromGitHub {
      owner = "mfussenegger";
      repo = "nvim-dap";
      rev = "273890967e76322f726405e6c6c79d4fc69ae068";
      sha256 = "0azk7n06kn2n4l0xdyvbhvmgzq0rp24dng7vlkairl0sm3bnb3x9";
    };
  };

  lspsaga-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "lspsaga-nvim";
    version = "2021-02-22";
    src = pkgs.fetchFromGitHub {
      owner = "glepnir";
      repo = "lspsaga.nvim";
      rev = "1fb30cb0334a0b12aa1dbf40a00e7a06c9539f44";
      sha256 = "0kvfbcck0f3nj5fb08yr2yfpp0cszxxp556jix59g3y6drah6bnn";
    };
  };

  snippets-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "snippets-nvim";
    version = "2021-02-12";
    src = pkgs.fetchFromGitHub {
      owner = "norcalli";
      repo = "snippets.nvim";
      rev = "7b5fd8071d4fb6fa981a899aae56b55897c079fd";
      sha256 = "1fdsx7d5nyhhklwidgh387ijd485g2836rwd5i1r0di777mp7w80";
    };
  };

  nvim-compe = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-compe";
    version = "2021-02-12";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "nvim-compe";
      rev = "4df0108195dfbc36f6143a7d0e1f6bf6418432b8";
      sha256 = "0xrl4wr6g9ax8xp6lj1b66phfzdqjilr2xglcdi9czib3hs29mf3";
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
