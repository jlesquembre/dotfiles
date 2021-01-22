{ config, pkgs, lib, ... }:
let
  custom = (import ./neovim-deps.nix) { pkgs = pkgs; };

  vimDir = toString ../dotfiles/neovim;

  # TODO extract
  readFileIfExists = f:
    if builtins.pathExists f then
      (builtins.readFile f)
    else
      "";
  compileAniseed = text:
    let
      version = "3.12.0";
      aniseed = pkgs.fetchFromGitHub {
        owner = "olical";
        repo = "aniseed";
        rev = "v${version}";
        sha256 = "1wy5jd86273q7sxa50kv88flqdgmg9z2m4b6phpw3xnl5d1sj9f7";
      };
      input = pkgs.writeText "input.fnl" text;
    in
    builtins.readFile (
      pkgs.runCommand ""
        {
          allowSubstitues = false;
          preferLocalBuild = true;
        }
        ''
          ${pkgs.neovim}/bin/nvim -u NONE -i NONE --headless \
              -c "let &runtimepath = &runtimepath . ',${aniseed}'" \
              -c "lua require('aniseed.compile').file('${input}', os.getenv('out'))" \
              +q
        ''
    );

  pluginWithConfig' = dir: p: {
    plugin = p;
    config =
      let
        name = lib.strings.getName p;
        path = "${dir}/${name}";
        vimConfig = readFileIfExists "${path}.vim";
        luaConfig = readFileIfExists "${path}.lua";
        aniseedConfig = readFileIfExists "${path}.fnl";
      in
      vimConfig
      +
      lib.strings.optionalString
        (builtins.stringLength luaConfig > 0)
        ''
          lua << EOF
          ${luaConfig}
          EOF
        ''
    ;
    # + (
    #   lib.strings.optionalString
    #     (builtins.stringLength aniseedConfig > 0)
    #     (
    #       compileAniseed
    #         ''
    #           lua << EOF
    #           ${aniseedConfig}
    #           EOF
    #         ''
    #     )
    # );
  };

  pluginWithConfig = pluginWithConfig' vimDir;

in
{
  # Create a symlink to test config without a rebuild
  home.activation.symlink-nvim-lua-config =
    let
      targerDir = "$HOME/.config/nvim/lua";
      targerFile = "${targerDir}/user.lua";
    in
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [[ -L "${targerFile}" ]]; then
        rm "${targerFile}"
      elif [[ -e "${targerFile}" ]]; then
        errorEcho "Existing file '${targerFile}' is in the way"
        exit 1
      fi
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ${targerDir}
      $DRY_RUN_CMD ln -s $VERBOSE_ARG \
          ${vimDir}/user.lua ${targerFile}

    '';

  # Add all tree-sitter parsers
  home.file = lib.attrsets.mapAttrs'
    (name: drv: lib.attrsets.nameValuePair
      ("${config.xdg.configHome}/nvim/parser/" + (lib.strings.removePrefix "tree-sitter-" name) + ".so")
      { source = "${drv}/parser"; })
    pkgs.tree-sitter.builtGrammars;

  programs.neovim = {
    enable = true;
    package = custom.neovim-nightly;
    withNodeJs = true;
    # withPython = true;
    withPython3 = true;
    withRuby = true;
    extraConfig = (builtins.readFile "${vimDir}/init.vim");

    # Needed to start the LSP servers
    extraPackages = [
      # typescript is needed because it provides the tsserver command.
      # First, it will try to find a tsserver installed with npm install,
      # if not found, it will look in our $PATH
      # See https://github.com/theia-ide/typescript-language-server/blob/a92027377b7ba8b1c9318baad98045e5128baa8e/server/src/lsp-server.ts#L75-L94
      pkgs.nodePackages.typescript
      pkgs.nodePackages.typescript-language-server

      pkgs.nodePackages.bash-language-server
      pkgs.nodePackages.vim-language-server
      pkgs.nodePackages.yaml-language-server
      pkgs.nodePackages.vscode-css-languageserver-bin
      pkgs.nodePackages.dockerfile-language-server-nodejs
      pkgs.nodePackages.dockerfile-language-server-nodejs
      pkgs.nodePackages.vscode-html-languageserver-bin
      pkgs.nodePackages.vscode-json-languageserver

      # Language Servers
      pkgs.clojure-lsp
      pkgs.gopls
      pkgs.jdt-ls
      pkgs.rls
      pkgs.rnix-lsp
      pkgs.terraform-ls

      # Formatters
      pkgs.nodePackages.prettier
      pkgs.nixpkgs-fmt
      pkgs.rustfmt
      pkgs.terraform
    ];
    plugins = with pkgs.vimPlugins; [

      pkgs.vimPlugins.nvim-web-devicons

      # config for plugins is also in nvim-treesitter config file
      (pluginWithConfig pkgs.vimPlugins.nvim-treesitter)
      pkgs.vimPlugins.nvim-ts-rainbow

      pkgs.vimPlugins.popup-nvim
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.telescope-fzy-native-nvim
      (pluginWithConfig pkgs.vimPlugins.telescope-nvim)

      (pluginWithConfig pkgs.vimPlugins.nvim-lspconfig)
      custom.nvim-jdtls

      (pluginWithConfig pkgs.vimPlugins.completion-nvim)
      pkgs.vimPlugins.completion-treesitter

      # UI
      # TODO use the lua version
      pkgs.vimPlugins.base16-vim
      pkgs.vimPlugins.oceanic-next
      (pluginWithConfig custom.galaxyline-nvim)
      # pkgs.vimPlugins.barbar-nvim
      # custom.nvim-bufferline-lua
      {
        plugin = pkgs.vimPlugins.vim-startify;
        config =
          ''
            let g:startify_change_to_vcs_root = 1
            let g:startify_session_dir = '~/.config/nvim/session'
          '';
      }

      # Navigation
      (pluginWithConfig pkgs.vimPlugins.fern-vim)
      pkgs.vimPlugins.vim-unimpaired
      # fzf-vim
      {
        plugin = pkgs.vimPlugins.vim-grepper;
        config =
          ''
            let g:grepper = {
                \ 'tools': ['rgextra', 'rg', 'git', 'grep'],
                \ 'highlight': 0,
                \ 'rgextra':
                \   { 'grepprg':    "rg --no-heading --vimgrep --hidden -g '!.git/' -S",
                \     'grepformat': '%f:%l:%c:%m',
                \     'escape':     '\^$.*+?()[]{}|' },
                \ }
            nnoremap gss  :Grepper<cr>
            nmap gs  <plug>(GrepperOperator)
            xmap gs  <plug>(GrepperOperator)
          '';
      }
      (pluginWithConfig pkgs.vimPlugins.vim-easymotion)

      # visual-star
      # vim-indent-object TODO ?

      # Text edition
      pkgs.vimPlugins.vim-repeat
      (pluginWithConfig pkgs.vimPlugins.vim-sandwich)
      pkgs.vimPlugins.vim-commentary
      # jdaddy-vim TODO needed? tree sitter can replace it?
      # vim-speeddating
      # ultisnips
      # vim-snippets
      pkgs.vimPlugins.NrrwRgn
      # vim-exchange
      # transpose-words
      pkgs.vimPlugins.vim-capslock

      # Utils
      custom.vim-alias
      # vim-dispatch
      # vim-abolish
      pkgs.vimPlugins.vim-eunuch
      # vim-dotenv
      {
        plugin = pkgs.vimPlugins.vim-rsi;
        config =
          ''
            " Add insertmode commands and remove some from rsi.vim
            " augroup readline
            "   autocmd!
            "   autocmd VimEnter * iunmap   <C-d>
            "   autocmd VimEnter * iunmap   <C-f>
            "   autocmd VimEnter * inoremap <C-y> <C-r><C-o>+
            "   autocmd VimEnter * cnoremap <C-y> <C-r><C-o>+
            " augroup END
          '';
      }
      # # vim-dispatch-neovim
      {
        plugin = pkgs.vimPlugins.editorconfig-vim;
        config =
          ''
            let g:EditorConfig_exclude_patterns = ['fugitive://.*']
          '';
      }

      # rainbow_parentheses-vim
      # vim-projectionist
      # ale
      (pluginWithConfig custom.formatter-nvim)
      pkgs.vimPlugins.vim-gnupg
      custom.nvim-toggleterm-lua
      # neoterm
      {
        plugin = pkgs.vimPlugins.vim-sayonara;
        config =
          ''
            let g:sayonara_confirm_quit = 0
            nnoremap <leader>q :Sayonara<cr>
            nnoremap <leader>Q :Sayonara!<cr>
          '';
      }
      pkgs.vimPlugins.vim-test
      #
      # vim-qf
      # Recover-vim
      # # vim-localvimrc

      # # Git
      # fugitive
      {
        plugin = pkgs.vimPlugins.fugitive;
        config =
          ''
            nnoremap <leader>gww :Gwrite<CR>
            nnoremap <leader>grr :Gread<CR>
            " <Bar> is the pipe (|) char. Gwrite output is shown, and Gcommit is not
            " executed if there is an error with Gwrite, and alternative map is:
            " nnoremap <leader>gwc :Gwrite<CR>:Gcommit<CR>
            " but in that case we lose the Gwrite output (unless there is an error)
            nnoremap <leader>gwc :Gwrite<Bar>:Gcommit<CR>
            nnoremap <leader>gd :Gdiff<CR>
            nnoremap <leader>gg :G<CR>
            nnoremap <leader>gcc :Gcommit<CR>
            "nnoremap <leader>gp :Gpush<CR>
            "nnoremap <leader>gr :Git reset -q -- %<CR>
            " nnoremap <leader>gll :GV!<CR>
            " nnoremap <leader>glr :GV?<CR>
            " nnoremap <leader>gla :GV<CR>
            nnoremap <leader>gll :Flog -path=%<CR>
            nnoremap <leader>gla :Flog -all<CR>

            nnoremap <leader>gb :MerginalToggle<CR>


            "# TODO move?
            function! Flogdiff(mods) abort
              let l:path = fnameescape(flog#get_state().path[0])
              let l:commit = flog#get_commit_data(line('.')).short_commit_hash
              call flog#preview(a:mods . ' split ' . l:path . ' | Gvdiff ' . l:commit)
            endfunction

            augroup flog
              autocmd!
              autocmd FileType floggraph command! -buffer -nargs=0 Flogdiff call Flogdiff('<mods>')
              autocmd FileType floggraph nnoremap <buffer> gd :Flogdiff<CR>

              autocmd FileType floggraph map <buffer> o :call myflog#close_term_preview()<CR>:vertical belowright Flogsplitcommit<CR>
              autocmd FileType floggraph nmap <buffer> <leader>q :call myflog#quit()<CR>

              autocmd FileType floggraph command! -buffer -nargs=0 Myflogsplitcommit call myflog#diff_fancy()
              autocmd FileType floggraph nnoremap <buffer> <silent> <CR> :Myflogsplitcommit<CR>
              autocmd FileType floggraph nnoremap <buffer> <silent> J :call myflog#scroll_down()<CR>
              autocmd FileType floggraph nnoremap <buffer> <silent> K :call myflog#scroll_up()<CR>

              autocmd FileType floggraph nnoremap <buffer> <silent> <c-n> :call myflog#preview_next_commit()<CR>
              autocmd FileType floggraph nnoremap <buffer> <silent> <c-p> :call myflog#preview_prev_commit()<CR>
            augroup END

            augroup open_folds_gitlog
              autocmd!
              autocmd Syntax git setlocal foldmethod=syntax
              autocmd Syntax git normal zR
            augroup END

            " start insert mode when entering the commit buffer. See https://stackoverflow.com/a/50537836/
            augroup turbo_commit
              autocmd!
              autocmd BufEnter COMMIT_EDITMSG startinsert
              autocmd BufEnter COMMIT_EDITMSG inoremap <C-s> <esc>ZZ
            augroup END
          '';
      }
      # vim-rhubarb
      # vim-gitgutter
      (pluginWithConfig custom.gitsigns-nvim)
      # vim-rooter
      # vim-flog
      # # vim-merginal

      # DB
      pkgs.vimPlugins.vim-dadbod

      # Syntax (prefer treesitter, but some languages are not well supported)
      # pgsql-vim
      # vim-git

      # vim-markdown
      # {
      #   plugin = pkgs.vimPlugins.vim-markdown;
      #   config =
      #     ''
      #       let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
      #     '';
      # }
      pkgs.vimPlugins.fennel-vim
      pkgs.vimPlugins.vim-fish
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.vim-terraform
      # pkgs.vimPlugins.vim-toml
      # pkgs.vimPlugins.vim-yaml
      # vim-mustache-handlebars
      # nginx-vim
      # vim-systemd-syntax
      # rust-vim
      # fennel-vim
      # # janet-vim
      # # i3-vim-syntax
      # vim-jsonnet
      # vim-scala
      # # just-vim


      # # JS / TS
      # vim-javascript
      # typescript-vim
      # vim-html-template-literals
      # # vim-mdx-js


      # # Other
      # # vim-hexokinase

      # Clojure
      pkgs.vimPlugins.vim-sexp
      pkgs.vimPlugins.vim-sexp-mappings-for-regular-people
      pkgs.parinfer-rust
      pkgs.vimPlugins.aniseed
      (pluginWithConfig pkgs.vimPlugins.conjure)
      # vim-clojure-highlight
      # # vim-kibit
      # # vim-slamhound

      # # Language specific helpers
      # vim-crates
    ];

    # configure = {

    #   packages.customVimPlugins = with pkgs.vimPlugins; {
    #     # loaded on launch
    #     start = [
    #       # Colors
    #       base16-vim
    #       oceanic-next
    #       vim-devicons

    #       # Navigation
    #       fern-vim
    #       fern-nerdfont
    #       nerdfont
    #       vim-unimpaired
    #       fzf-vim
    #       # fzf-preview
    #       # fzf-checkout
    #       vim-grepper
    #       # ctrlsf
    #       vim-easymotion
    #       visual-star
    #       vim-indent-object

    #       # Text edition
    #       vim-repeat
    #       vim-sandwich
    #       vim-commentary
    #       jdaddy-vim
    #       vim-speeddating
    #       ultisnips
    #       vim-snippets
    #       NrrwRgn
    #       vim-exchange
    #       transpose-words
    #       capslock

    #       # UI
    #       vim-airline
    #       vim-startify
    #       vim-highlightedyank
    #       # vim-airline-themes

    #       # Utils
    #       vim-alias
    #       vim-dispatch
    #       vim-abolish
    #       vim-eunuch
    #       vim-dotenv
    #       vim-rsi
    #       # vim-dispatch-neovim
    #       editorconfig-vim
    #       rainbow_parentheses-vim
    #       vim-projectionist
    #       ale
    #       neoterm
    #       vim-sayonara
    #       vim-qf
    #       Recover-vim
    #       # vim-localvimrc

    #       # Git
    #       fugitive
    #       vim-rhubarb
    #       vim-gitgutter
    #       vim-rooter
    #       vim-flog
    #       # vim-merginal

    #       # DB
    #       vim-dadbod

    #       # Syntax
    #       pgsql-vim
    #       vim-git
    #       vim-markdown
    #       vim-fish
    #       vim-yaml
    #       vim-mustache-handlebars
    #       nginx-vim
    #       vim-systemd-syntax
    #       rust-vim
    #       fennel-vim
    #       # janet-vim
    #       # i3-vim-syntax
    #       vim-nix
    #       vim-toml
    #       vim-jsonnet
    #       vim-scala
    #       # just-vim


    #       # JS / TS
    #       vim-javascript
    #       typescript-vim
    #       vim-html-template-literals
    #       # vim-mdx-js


    #       # Other
    #       # vim-hexokinase

    #       # COC
    #       coc-nvim
    #       # coc-word
    #       coc-pairs
    #       coc-lists
    #       coc-prettier
    #       coc-json
    #       coc-css
    #       coc-html
    #       coc-tsserver
    #       coc-tslint
    #       coc-yaml
    #       # coc-conjure
    #       coc-snippets
    #       coc-emmet
    #       # coc-angular

    #       # Clojure
    #       vim-sexp
    #       vim-sexp-mappings-for-regular-people
    #       vim-clojure-highlight
    #       # parinfer-rust
    #       # vim-kibit
    #       conjure
    #       # vim-slamhound

    #       # Language specific helpers
    #       vim-crates

    #     ];
    #     # manually loadable by calling `:packadd $plugin-name`
    #     opt = [
    #       vimtex
    #       purescript-vim
    #       vim-ruby
    #     ];
    #   };

    #   customRC = ''
    #     set termguicolors

    #     " The fish shell is not very compatible to other shells and unexpectedly
    #     " breaks things that use 'shell'.
    #     if &shell =~# 'fish$'
    #       set shell=bash
    #       let $SHELL='bash'
    #     endif

    #     set hidden
    #     set relativenumber
    #     set number
    #     set tildeop
    #     set ignorecase
    #     set smartcase
    #     set noshowmode
    #     set showcmd                 " display incomplete commands
    #     set cursorline
    #     set clipboard+=unnamedplus  " Use "+ register
    #     set inccommand=split
    #     set updatetime=100          " Also used for the CursorHold autocommand
    #     set previewheight=15
    #     set undofile
    #     " set lazyredraw

    #     " Better folds
    #     set foldmethod=marker

    #     let mapleader="\<SPACE>"
    #     let maplocalleader="\<SPACE>"

    #     " Backups

    #     set backup
    #     set swapfile

    #     let tmpvim_dir = "/tmp/nvim/"
    #     execute "set backupdir=".tmpvim_dir."backup/"
    #     execute "set undodir=".tmpvim_dir."undo/"
    #     " the double // at the end is import see :h dir
    #     execute "set directory=".tmpvim_dir."swap//"
    #     set shada='1000,<500,s100,h " file saved at ~/.local/share/nvim
    #     set viewdir=$HOME/.config/nvim/views

    #     " make this dirs if no exists previously
    #     function! MakeDirIfNoExists(path)
    #         if !isdirectory(expand(a:path))
    #             call mkdir(expand(a:path), "p")
    #         endif
    #     endfunction
    #     silent! call MakeDirIfNoExists(&backupdir)
    #     silent! call MakeDirIfNoExists(&undodir)
    #     silent! call MakeDirIfNoExists(&directory)
    #     silent! call MakeDirIfNoExists(&viewdir)


    #     " Make sure you dont change logfiles
    #     augroup readonly_files
    #       autocmd!
    #       autocmd BufNewFile,BufRead /var/log/* set readonly
    #       autocmd BufNewFile,BufRead /var/log/* set nomodifiable
    #     augroup END


    #     augroup CustomFileTypeDetection
    #       autocmd!
    #       autocmd BufRead,BufNewFile Tiltfile setfiletype bzl
    #     augroup END

    #     " Set augroup
    #     " See https://vi.stackexchange.com/a/9458/2660
    #     augroup user_augroup
    #       autocmd!
    #       autocmd FileType help wincmd K

    #       " Help NeoVim check for modified files: https://github.com/neovim/neovim/issues/2127
    #       " autocmd BufEnter,FocusGained * checktime
    #       " autocmd BufEnter,FocusGained * if mode() != 'c' | checktime | endif
    #       autocmd BufEnter,FocusGained * if !bufexists("[Command Line]") | checktime | endif


    #       " The PC is fast enough, do syntax highlight syncing from start
    #       autocmd BufEnter * syntax sync fromstart

    #       " Only use cursorline for current window
    #       autocmd WinEnter,FocusGained * setlocal cursorline
    #       autocmd WinLeave,FocusLost   * setlocal nocursorline

    #       " jsonc support
    #       autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
    #       autocmd FileType jsonc call SetJsoncOptions()
    #       autocmd FileType json  syntax match Comment +\/\/.\+$+

    #     augroup END

    #     function SetJsoncOptions()
    #       source $VIMRUNTIME/syntax/json.vim
    #       syntax match Comment +\/\/.\+$+
    #       setlocal commentstring=//\ %s
    #     endfunction
    #   ''
    #   + (builtins.readFile "${vimDir}/init.vim");
    # };

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
