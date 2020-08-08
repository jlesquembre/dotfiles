{ config, pkgs, lib, ... }:
let
  vimDir = toString ../dotfiles/neovim;

  fern-vim = pkgs.vimUtils.buildVimPlugin {
    name = "fern-vim";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "fern.vim";
      rev = "v1.14.0";
      sha256 = "196rmfrzb9rb4cmkf9x41vmjdnn9v2vc99ynrgnyaq7ciyrgy13w";
    };
  };

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
      sha256 = "17cay94gvaqvxhq3vij2f8pcyfpgrf74lhwbwpwfciwqs9czg0hw";
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

in
{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython = true;
    withPython3 = true;
    withRuby = true;

    configure = {

      packages.customVimPlugins = with pkgs.vimPlugins; {
        # loaded on launch
        start = [
          # Colors
          base16-vim
          oceanic-next
          vim-devicons

          # Navigation
          fern-vim
          fern-nerdfont
          nerdfont
          vim-unimpaired
          fzf-vim
          # fzf-preview
          # fzf-checkout
          vim-grepper
          # ctrlsf
          vim-easymotion
          visual-star
          vim-indent-object

          # Text edition
          vim-repeat
          vim-sandwich
          vim-commentary
          jdaddy-vim
          vim-speeddating
          ultisnips
          vim-snippets
          NrrwRgn
          vim-exchange
          transpose-words
          capslock

          # UI
          vim-airline
          vim-startify
          vim-highlightedyank
          # vim-airline-themes

          # Utils
          vim-alias
          vim-dispatch
          vim-abolish
          vim-eunuch
          vim-dotenv
          vim-rsi
          # vim-dispatch-neovim
          editorconfig-vim
          rainbow_parentheses-vim
          vim-projectionist
          ale
          vim-gnupg
          neoterm
          vim-sayonara
          vim-qf
          Recover-vim
          # vim-localvimrc

          # Git
          fugitive
          vim-rhubarb
          vim-gitgutter
          vim-rooter
          vim-flog
          # vim-merginal

          # DB
          vim-dadbod

          # Syntax
          pgsql-vim
          vim-git
          vim-markdown
          vim-fish
          vim-yaml
          vim-mustache-handlebars
          nginx-vim
          vim-systemd-syntax
          rust-vim
          fennel-vim
          # janet-vim
          # i3-vim-syntax
          vim-nix
          vim-toml
          vim-jsonnet
          vim-scala
          # just-vim


          # JS / TS
          vim-javascript
          typescript-vim
          vim-html-template-literals
          # vim-mdx-js


          # Other
          # vim-hexokinase

          # COC
          coc-nvim
          # coc-word
          coc-pairs
          coc-lists
          coc-prettier
          coc-json
          coc-css
          coc-html
          coc-tsserver
          coc-tslint
          coc-yaml
          # coc-conjure
          coc-snippets
          coc-emmet
          # coc-angular

          # Clojure
          vim-sexp
          vim-sexp-mappings-for-regular-people
          vim-clojure-highlight
          # parinfer-rust
          # vim-kibit
          conjure
          # vim-slamhound

          # Language specific helpers
          vim-crates

        ];
        # manually loadable by calling `:packadd $plugin-name`
        opt = [
          vimtex
          purescript-vim
          vim-ruby
        ];
      };

      customRC = ''
        set termguicolors

        " The fish shell is not very compatible to other shells and unexpectedly
        " breaks things that use 'shell'.
        if &shell =~# 'fish$'
          set shell=bash
          let $SHELL='bash'
        endif

        set hidden
        set relativenumber
        set number
        set tildeop
        set ignorecase
        set smartcase
        set noshowmode
        set showcmd                 " display incomplete commands
        set cursorline
        set clipboard+=unnamedplus  " Use "+ register
        set inccommand=split
        set updatetime=100          " Also used for the CursorHold autocommand
        set previewheight=15
        set undofile
        " set lazyredraw

        " Better folds
        set foldmethod=marker

        let mapleader="\<SPACE>"
        let maplocalleader="\<SPACE>"

        " Backups

        set backup
        set swapfile

        let tmpvim_dir = "/tmp/nvim/"
        execute "set backupdir=".tmpvim_dir."backup/"
        execute "set undodir=".tmpvim_dir."undo/"
        " the double // at the end is import see :h dir
        execute "set directory=".tmpvim_dir."swap//"
        set shada='1000,<500,s100,h " file saved at ~/.local/share/nvim
        set viewdir=$HOME/.config/nvim/views

        " make this dirs if no exists previously
        function! MakeDirIfNoExists(path)
            if !isdirectory(expand(a:path))
                call mkdir(expand(a:path), "p")
            endif
        endfunction
        silent! call MakeDirIfNoExists(&backupdir)
        silent! call MakeDirIfNoExists(&undodir)
        silent! call MakeDirIfNoExists(&directory)
        silent! call MakeDirIfNoExists(&viewdir)


        " Make sure you dont change logfiles
        augroup readonly_files
          autocmd!
          autocmd BufNewFile,BufRead /var/log/* set readonly
          autocmd BufNewFile,BufRead /var/log/* set nomodifiable
        augroup END


        augroup CustomFileTypeDetection
          autocmd!
          autocmd BufRead,BufNewFile Tiltfile setfiletype bzl
        augroup END

        " Set augroup
        " See https://vi.stackexchange.com/a/9458/2660
        augroup user_augroup
          autocmd!
          autocmd FileType help wincmd K

          " Help NeoVim check for modified files: https://github.com/neovim/neovim/issues/2127
          " autocmd BufEnter,FocusGained * checktime
          " autocmd BufEnter,FocusGained * if mode() != 'c' | checktime | endif
          autocmd BufEnter,FocusGained * if !bufexists("[Command Line]") | checktime | endif


          " The PC is fast enough, do syntax highlight syncing from start
          autocmd BufEnter * syntax sync fromstart

          " Only use cursorline for current window
          autocmd WinEnter,FocusGained * setlocal cursorline
          autocmd WinLeave,FocusLost   * setlocal nocursorline

          " jsonc support
          autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
          autocmd FileType jsonc call SetJsoncOptions()
          autocmd FileType json  syntax match Comment +\/\/.\+$+

        augroup END

        function SetJsoncOptions()
          source $VIMRUNTIME/syntax/json.vim
          syntax match Comment +\/\/.\+$+
          setlocal commentstring=//\ %s
        endfunction
      ''
      + (builtins.readFile "${vimDir}/init.vim");
    };

    # plugins =
    #   with pkgs.vimPlugins; {
    #     start = [

    #       # Colors
    #       base16-vim
    #       oceanic-next
    #       vim-devicons

    #       # Navigation
    #       vim-unimpaired
    #       # fern-vim

    #       # Text edition
    #       vim-repeat
    #     ];
    #     opt = [
    #       fugitive
    #     ];
    #   };

    # extraConfig = ''
    #   set termguicolors

    #   " The fish shell is not very compatible to other shells and unexpectedly
    #   " breaks things that use 'shell'.
    #   if &shell =~# 'fish$'
    #     set shell=bash
    #     let $SHELL='bash'
    #   endif

    #   set hidden
    #   set relativenumber
    #   set number
    #   set tildeop
    #   set ignorecase
    #   set smartcase
    #   set noshowmode
    #   set showcmd                 " display incomplete commands
    #   set cursorline
    #   set clipboard+=unnamedplus  " Use "+ register
    #   set inccommand=split
    #   set updatetime=100          " Also used for the CursorHold autocommand
    #   set previewheight=15
    #   set undofile
    #   " set lazyredraw

    #   " Better folds
    #   set foldmethod=marker

    #   let mapleader="\<SPACE>"
    #   let maplocalleader="\<SPACE>"
    # '';



  };
}
