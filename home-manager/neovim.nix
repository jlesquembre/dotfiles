{ config, pkgs, lib, ... }:
let
  custom = (import ./neovim-deps.nix) { pkgs = pkgs; };
  # neovim-nightly = import
  #   (builtins.fetchTarball {
  #     url = https://github.com/mjlbach/neovim-nightly-overlay/archive/2abd19b4964d1f15617d04b4fba6bdc0db39d27e.tar.gz;
  #     sha256 = "1x7cwsbhp6vz25x2lkilhn938xa7na9xvg99mfyaww84hl7v1frv";
  #   })
  #   { }
  #   { };

  vimDir = toString ../dotfiles/neovim;

  # TODO extract
  readFileIfExists = f:
    if builtins.pathExists f then
      (builtins.readFile f)
    else
      "";
  pluginWithConfig2 = dir: p: {
    plugin = p;
    config =
      let
        name = lib.strings.getName p;
        path = "${dir}/${name}";
        vimConfig = readFileIfExists "${path}.vim";
        luaConfig = readFileIfExists "${path}.lua";
        # path = if builtins.pathExists "${path}.lua" then "${path}.lua" else "${path}";
      in
      vimConfig
      +
      lib.strings.optionalString
        (builtins.stringLength luaConfig > 0)
        ''
          lua << EOF
          ${luaConfig}
          EOF
        '';
  };

  pluginWithConfig = pluginWithConfig2 vimDir;

in
{
  programs.neovim = {
    enable = true;
    # package = custom.(neovim-nightly.neovim-nightly);
    package = custom.neovim-nightly;
    withNodeJs = true;
    # withPython = true;
    withPython3 = true;
    withRuby = true;
    extraConfig = (builtins.readFile "${vimDir}/init2.vim");
    plugins = with pkgs.vimPlugins; [


      {
        plugin = pkgs.vimPlugins.nvim-treesitter;
        config =
          ''
          '';
      }
      {
        plugin = pkgs.vimPlugins.popup-nvim;
        config =
          ''
          '';
      }
      {
        plugin = pkgs.vimPlugins.plenary-nvim;
        config =
          ''
          '';
      }
      (pluginWithConfig pkgs.vimPlugins.telescope-nvim)
      # {
      #   plugin = pkgs.vimPlugins.telescope-nvim;
      #   config =
      #     ''
      #     '';
      # }
      {
        plugin = pkgs.vimPlugins.nvim-tree-lua;
        config =
          ''
          '';
      }


      pkgs.vimPlugins.base16-vim
      pkgs.vimPlugins.oceanic-next
      {
        plugin = pkgs.vimPlugins.vim-startify;
        config =
          ''
            let g:startify_change_to_vcs_root = 1
            let g:startify_session_dir = '~/.config/nvim/session'
          '';
      }
      # vim-devicons

      # # Navigation
      # fern-vim
      # fern-nerdfont
      # nerdfont
      # vim-unimpaired
      # fzf-vim
      # # fzf-preview
      # # fzf-checkout
      # vim-grepper
      # # ctrlsf
      # vim-easymotion
      (pluginWithConfig pkgs.vimPlugins.vim-easymotion)
      # {
      #   plugin = pkgs.vimPlugins.vim-easymotion;
      #   config =
      #     ''
      #     '';
      # }

      # visual-star
      # vim-indent-object

      # # Text edition
      # vim-repeat
      # vim-sandwich
      {
        plugin = pkgs.vimPlugins.vim-sandwich;
        config =
          ''
            nmap s <Nop>
            xmap s <Nop>

            "let g:sandwich_no_default_key_mappings = 1

            onoremap <SID>line :normal! ^vg_<CR>
            nmap sa <Plug>(operator-sandwich-add)
            nmap sal <Plug>(operator-sandwich-add)<SID>line

            nmap sdd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
            nmap srr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)

            " select the nearest surrounded text automatically
            xmap iss <Plug>(textobj-sandwich-auto-i)
            xmap ass <Plug>(textobj-sandwich-auto-a)
            omap iss <Plug>(textobj-sandwich-auto-i)
            omap ass <Plug>(textobj-sandwich-auto-a)
          '';
      }
      # vim-commentary
      # jdaddy-vim
      # vim-speeddating
      # ultisnips
      # vim-snippets
      # NrrwRgn
      # vim-exchange
      # transpose-words
      # capslock

      # # UI
      # vim-airline
      # vim-startify
      # vim-highlightedyank
      # # vim-airline-themes

      # # Utils
      # vim-alias
      # vim-dispatch
      # vim-abolish
      # vim-eunuch
      # vim-dotenv
      # vim-rsi
      # # vim-dispatch-neovim
      # editorconfig-vim
      # rainbow_parentheses-vim
      # vim-projectionist
      # ale
      # vim-gnupg
      # neoterm
      # vim-sayonara
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
            nnoremap <leader>gp :Gpush<CR>
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
      {
        plugin = pkgs.vimPlugins.vim-gitgutter;
        config =
          ''
            let g:gitgutter_map_keys = 0
            nmap ]h <Plug>(GitGutterNextHunk)
            nmap [h <Plug>(GitGutterPrevHunk)
            nmap <Leader>hs <Plug>(GitGutterStageHunk)
            nmap <Leader>hd <Plug>(GitGutterUndoHunk)
            nmap <Leader>hp <Plug>(GitGutterPreviewHunk)
            omap ih <Plug>(GitGutterTextObjectInnerPending)
            omap ah <Plug>(GitGutterTextObjectOuterPending)
            xmap ih <Plug>(GitGutterTextObjectInnerVisual)
            xmap ah <Plug>(GitGutterTextObjectOuterVisual)
          '';
      }
      # vim-rooter
      # vim-flog
      # # vim-merginal

      # # DB
      # vim-dadbod

      # # Syntax
      # pgsql-vim
      # vim-git

      # vim-markdown
      {
        plugin = pkgs.vimPlugins.vim-markdown;
        config =
          ''
            let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
          '';
      }
      # vim-fish
      # vim-yaml
      # vim-mustache-handlebars
      # nginx-vim
      # vim-systemd-syntax
      # rust-vim
      # fennel-vim
      # # janet-vim
      # # i3-vim-syntax
      # vim-nix
      # vim-toml
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

      # # COC
      # coc-nvim
      # # coc-word
      # coc-pairs
      # coc-lists
      # coc-prettier
      # coc-json
      # coc-css
      # coc-html
      # coc-tsserver
      # coc-tslint
      # coc-yaml
      # # coc-conjure
      # coc-snippets
      # coc-emmet
      # # coc-angular

      # # Clojure
      # vim-sexp
      # vim-sexp-mappings-for-regular-people
      # vim-clojure-highlight
      # # parinfer-rust
      # # vim-kibit
      # conjure
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
    #       vim-gnupg
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
