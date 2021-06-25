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
  pluginWithConfig' = { configPath, drv, from ? null, to ? null }: {
    plugin = drv;
    config = replaceStringsOptional from to (builtins.readFile configPath);
  };
  pluginWithConfig = drv: configPath: (pluginWithConfig' { inherit drv configPath; });
  pluginWithConfigTemplate = drv: configPath: from: to: (pluginWithConfig' { inherit drv configPath from to; });

  /**
    * Creates a vim plugin derivation with multiple lua files.

    * Example:
    * let
    *   my-lua-files = (buildLuaConfig { configDir = /path/to/dir; moduleName = "foo"; })
    * in
    * {
    *   programs.neovim.extraPackages = [ my-lua-files ];
    *   # Optional, to automatically load the files on startup, since lua files are
    *   # not automatically sourced
    *   programs.neovim.extraConfig = my-lua-files.luaRequires;
    *   # luaRequires example:
    *   # lua require'foo.filename'
    * }
    * And then, in your init.vim you can do:
    * lua require'foo.filename'



    * Optionally provide 'vars' and 'replacements' to perform string substitution.
    * Substitutions are similar (but not identical) to how builtins.replaceStrings behaves.
    * See https://nixos.org/manual/nix/stable/#builtin-replaceStrings

    * Variables in the lua files have to be sorrounded by the @ symbol.
    * Example:
    *   vars = [ "foo" "bar"]; replacements = [ "FOO" "BAR"];

    *   Input file ->
    *     @foo@  = @bar@

    *   Output file ->
    *     FOO = BAR
  */
  buildLuaConfig = { configDir, moduleName, vars ? null, replacements ? null }:
    let
      pname = "lua-config-${moduleName}";
      luaSrc = builtins.filterSource
        (path: type: (lib.hasSuffix ".lua" path) && (baseNameOf path != "user.lua"))
        configDir;
      luaRequires = pkgs.runCommand "luaRequires-${moduleName}" { } ''
        echo '" ${pname} ===' > $out
        for filename in ${luaSrc}/*.lua
        do
          f=$(basename "''${filename}" .lua)
          echo "lua require'${moduleName}.''${f}'" >> $out
        done
        echo '" ===' >> $out
      '';
    in
    (pkgs.stdenv.mkDerivation {
      inherit pname;
      version = "DEV";
      src = luaSrc;
      installPhase =
        let
          rtpPath = "share/vim-plugins";
          subs =
            lib.concatStringsSep " "
              (lib.lists.zipListsWith (f: t: "--subst-var-by ${f} ${t}") vars replacements)
          ;
        in
        ''
          target=$out/${rtpPath}/${pname}/lua/${moduleName}
          mkdir -p $target
          cp -r . $target

        ''
        +
        lib.optionalString (vars != null)
          ''
            for filename in $target/*
            do
              substituteInPlace $filename ${subs}
            done
          '';
      passthru.luaRequires = builtins.readFile "${luaRequires}";
    });

  my-lua-config = (buildLuaConfig {
    configDir = vimDir;
    moduleName = "jlle";
    vars = [ "java.debug.plugin" ];
    replacements = [ "${custom.java-debug.jar}" ];
  });

in
{
  # Create a symlink to config without a rebuild
  xdg.configFile."nvim/lua/user.lua".source = config.lib.file.mkOutOfStoreSymlink (vimDir + /user.lua);

  programs.neovim = {
    enable = true;
    package = custom.neovim-nightly;
    withNodeJs = true;
    # withPython = true;
    withPython3 = true;
    withRuby = true;
    extraConfig =
      ''
        ${builtins.readFile "${vimDir}/init.vim"}
        ${builtins.readFile "${vimDir}/fern.vim"}
        ${builtins.readFile "${vimDir}/sandwich.vim"}
        lua require'user'
        ${my-lua-config.luaRequires}
      '';

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

      nvim-web-devicons
      # (compileAniFile /home/jlle/projects/private-gists/term.fnl)

      # config for plugins is also in nvim-treesitter config file
      nvim-treesitter
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      # if you only want some grammars do
      # (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [ p.tree-sitter-c p.tree-sitter-java ]))
      nvim-ts-rainbow

      # Helpers, needed by other plugins
      popup-nvim
      plenary-nvim
      sql-nvim
      aniseed

      # Telescope
      telescope-fzy-native-nvim
      telescope-nvim

      # LSP
      nvim-lspconfig
      lspsaga-nvim

      nvim-jdtls
      # (h.neovim.localVimPlugin (vimPluginsDir + /nvim-jdtls))
      nvim-dap

      snippets-nvim
      nvim-compe
      # pkgs.vimPlugins.completion-treesitter

      # UI
      nvim-base16
      galaxyline-nvim
      dashboard-nvim

      # Navigation
      fern-vim
      vim-unimpaired
      nvim-bqf
      vim-grepper

      # visual-star
      # vim-indent-object TODO ?

      # Text edition
      vim-repeat
      vim-sandwich
      vim-commentary
      # jdaddy-vim TODO needed? tree sitter can replace it?
      # vim-speeddating
      # ultisnips
      # vim-snippets
      NrrwRgn
      # vim-exchange
      # transpose-words
      vim-capslock

      # Utils
      vim-alias
      # vim-dispatch
      vim-abolish
      vim-eunuch
      # vim-dotenv
      vim-rsi
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
      formatter-nvim
      nvim-autopairs
      hop-nvim
      vim-gnupg
      vim-sayonara

      custom.nterm-nvim
      #
      # vim-qf
      # Recover-vim
      # # vim-localvimrc

      # # Git
      fugitive
      # vim-rhubarb
      gitsigns-nvim
      vim-flog

      # DB
      vim-dadbod

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
      vim-fish
      vim-nix
      vim-terraform
      vimtex
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
      vim-sexp
      vim-sexp-mappings-for-regular-people
      pkgs.parinfer-rust
      conjure
      compe-conjure
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
      my-lua-config
    ];
  };
}
