{ config, pkgs, lib, ... }:
let
  custom = (import ./neovim-deps.nix) { pkgs = pkgs; };

  vimDir = ../dotfiles/neovim;

  vimPluginsDir = ../../projects;

  h = import ../modules/helpers.nix { inherit pkgs; };

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

  replaceStringsOptional = from: to: s:
    if (from != null && s != "") then
      (builtins.replaceStrings from to s)
    else
      s;

  pluginWithConfig' = { dir, p, from ? null, to ? null }: {
    plugin = p;
    config =
      let
        name = lib.strings.getName p;
        path = "${toString dir}/${name}";
        vimConfig = replaceStringsOptional from to (readFileIfExists "${path}.vim");
        luaConfig = replaceStringsOptional from to (readFileIfExists "${path}.lua");
        # aniseedConfig = readFileIfExists "${path}.fnl";
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

  pluginWithConfig = p: (pluginWithConfig' { dir = vimDir; p = p; });
  pluginWithConfigTemplate = p: from: to: (pluginWithConfig' { dir = vimDir; inherit p from to; });
in
{
  # Create a symlink to config without a rebuild
  xdg.configFile."nvim/lua/user.lua".source = config.lib.file.mkOutOfStoreSymlink (vimDir + /user.lua);

  # TODO remove after TS update
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
      pkgs.nodePackages.dockerfile-language-server-nodejs
      pkgs.nodePackages.dockerfile-language-server-nodejs

      # TODO replace with vscode-css-languageservice?
      pkgs.nodePackages.vscode-css-languageserver-bin
      # TODO replace with vscode-html-languageservice?
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
      # (compileAniFile /home/jlle/projects/private-gists/term.fnl)

      # config for plugins is also in nvim-treesitter config file
      (pluginWithConfig pkgs.vimPlugins.nvim-treesitter)
      pkgs.vimPlugins.nvim-ts-rainbow

      # Helpers, needed by other plugins
      pkgs.vimPlugins.popup-nvim
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.sql-nvim
      pkgs.vimPlugins.aniseed

      # Telescope
      pkgs.vimPlugins.telescope-fzy-native-nvim
      (pluginWithConfig pkgs.vimPlugins.telescope-nvim)

      # LSP
      (pluginWithConfigTemplate pkgs.vimPlugins.nvim-lspconfig
        [ "@java.debug.plugin@" ] [ "${custom.java-debug.jar}" ])
      # pkgs.vimPlugins.lspsaga-nvim
      custom.lspsaga-nvim
      # pkgs.vimPlugins.nvim-jdtls
      # custom.nvim-jdtls
      (h.neovim.localVimPlugin (vimPluginsDir + /nvim-jdtls))
      custom.nvim-dap

      # (pluginWithConfig pkgs.vimPlugins.completion-nvim)
      (pluginWithConfig custom.snippets-nvim)
      # (pluginWithConfig pkgs.vimPlugins.nvim-compe)
      (pluginWithConfig custom.nvim-compe)
      # pkgs.vimPlugins.completion-treesitter

      # UI
      # TODO use the lua version
      pkgs.vimPlugins.base16-vim
      pkgs.vimPlugins.oceanic-next
      (pluginWithConfig pkgs.vimPlugins.galaxyline-nvim)
      # pkgs.vimPlugins.barbar-nvim
      # custom.nvim-bufferline-lua
      # pkgs.vimPlugins.dashboard-nvim
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
      pkgs.vimPlugins.vim-abolish
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
      # custom.nvim-toggleterm-lua
      (h.neovim.compileAniseedPluginLocal {
        src = "${config.home.homeDirectory}/projects/nterm.nvim";
        name = "nterm-nvim";
        fnlDir = "src";
      })
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
      (pluginWithConfig pkgs.vimPlugins.gitsigns-nvim)
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
      (pluginWithConfig pkgs.vimPlugins.conjure)
      {
        plugin = pkgs.vimPlugins.lispdocs-nvim;
        config =
          ''
            let g:lispdocs_mappings = 0
          '';
      }
      # vim-clojure-highlight
      # # vim-kibit
      # # vim-slamhound

      # # Language specific helpers
      # vim-crates
    ];
  };
}
