{ pkgs }:
let
  fetchFromGitHub = pkgs.fetchFromGitHub;
  buildVimPluginFrom2Nix = pkgs.vimUtils.buildVimPluginFrom2Nix;
in
{

  # TODO bundle it with jdt-ls?
  java-debug = pkgs.fetchMavenArtifact {
    groupId = "com.microsoft.java";
    artifactId = "com.microsoft.java.debug.plugin";
    version = "0.30.0";
    sha256 = "0xz33p397g4pw6y3ydb9yafh2vnws3ym0nljr3369k47gq0w02v5";
  };

  java-debug-p = pkgs.fetchMavenArtifact {
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
      rev = "bdf3df4027a5389a46b4c9a75b50aff5c0ecb351";
      sha256 = "0y0x35lr5bchx0m61qsz5x5fz54k775fwgvdjq5scsn6nsny2ksw";
    };

    buildInputs = oa.buildInputs ++ ([
      pkgs.tree-sitter
    ]);

    cmakeFlags = oa.cmakeFlags ++ [
      "-DUSE_BUNDLED=OFF"
    ];
  });

  ######
  ######
  ######
  ######
  ######
  ######

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

  vim-dotenv = pkgs.vimUtils.buildVimPlugin {
    name = "vim-dotenv";
    src = pkgs.fetchFromGitHub {
      owner = "tpope";
      repo = "vim-dotenv";
      rev = "master";
      sha256 = "130g0s6zzl228fcbc80d55v1wxw75hlyyvz42cwbipij5cl7vd17";
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
}
