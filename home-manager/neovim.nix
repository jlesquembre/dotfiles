{ config, pkgs, lib, nix-medley, ... }:
let
  nvim-deps = (import ./neovim-deps.nix) { pkgs = pkgs; };
  custom-vim-plugs = pkgs.vimPlugins.extend (
    (pkgs.callPackage ./neovim-plugins-generated.nix {
      buildVimPluginFrom2Nix = pkgs.vimUtils.buildVimPluginFrom2Nix;
    })
  );

  vimDir = ../dotfiles/neovim;

  vimPluginsDir = ../../projects;

  # TODO extract
  readFileIfExists = f:
    if builtins.pathExists f then
      (builtins.readFile f)
    else
      "";

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

      compiledFennel =
        if (nix-medley.hasFileWithSuffix configDir ".fnl") then
          nix-medley.neovim.compileAniseed { src = configDir; fnlDir = ""; outPrefix = "/"; }
        else null;

      luaRequires =
        let
          fnlSrc = if (isNull compiledFennel) then "" else "${compiledFennel}/*.lua";
        in
        pkgs.runCommand "luaRequires-${moduleName}" { } ''
          echo '" ${pname} ===' > $out
          for filename in ${luaSrc}/*.lua ${fnlSrc}
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
      srcs = [ luaSrc ] ++ (lib.optional (compiledFennel != null) compiledFennel);
      unpackPhase = ''
        for _src in $srcs; do
          cp -v $_src/* .
        done
      '';
      installPhase =
        let
          rtpPath = "share/vim-plugins";
          subs =
            lib.concatStringsSep " "
              (lib.lists.zipListsWith (f: t: "--subst-var-by ${f} ${t}") vars replacements)
          ;
        in
        ''
          target=$out/lua/${moduleName}
          mkdir -p $target
          cp -r *.lua $target
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
    replacements = [ "${nvim-deps.java-debug.jar}" ];
  });

in
{
  # Create a symlink to config without a rebuild
  xdg.configFile."nvim/lua/user.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/dotfiles/neovim/user.lua";

  programs.neovim = {
    enable = true;
    # package = nvim-deps.neovim-nightly;
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

      # Includes css, html and json language server
      pkgs.vscode-ls

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

      # if you only want some grammars do
      # (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [ p.tree-sitter-c p.tree-sitter-java ]))
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      nvim-ts-rainbow

      # Helpers, needed by other plugins
      popup-nvim
      plenary-nvim
      sqlite-lua
      aniseed
      nui-nvim

      # Telescope
      telescope-nvim

      # LSP
      nvim-lspconfig
      nvim-jdtls
      goto-preview
      # (h.neovim.localVimPlugin (vimPluginsDir + /nvim-jdtls))
      nvim-dap
      SchemaStore-nvim

      # auto completion
      luasnip
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-nvim-lua
      cmp_luasnip
      cmp-conjure
      lspkind-nvim
      # pkgs.vimPlugins.completion-treesitter

      # UI
      nvim-base16
      # custom-vim-plugs.feline-nvim
      feline-nvim
      # dashboard-nvim

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
      harpoon

      # nterm-nvim
      custom-vim-plugs.nterm-nvim
      # (h.neovim.localVimPlugin (vimPluginsDir + /nterm.nvim))

      # Git
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


      # JS / TS
      package-info-nvim
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
