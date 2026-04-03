# Based on
# https://ayats.org/blog/neovim-wrapper
{
  symlinkJoin,
  neovim-unwrapped,
  makeWrapper,
  runCommandLocal,
  vimPlugins,
  lib,
  writeText,
  pkgs,
}:
let
  packageName = "jlle-neovim";

  compileNfnl =
    {
      src,
      nfnl ? pkgs.vimPlugins.nfnl,
    }:
    let
      # Required to accept pkgs.vimPlugins AND pkgs.fetchFromGitHub
      nfnl-plugin-root = nfnl + /share/vim-plugins/nfnl;
      nfnl-root = if builtins.pathExists (nfnl-plugin-root) then nfnl-plugin-root else nfnl;

    in
    pkgs.runCommand "nfnl-output"
      {
        src = src;
        allowSubstitues = false;
        preferLocalBuild = true;
      }
      ''
        export HOME=$TMP/home
        export config_fnl=$TMP/config_files

        mkdir -p $HOME
        mkdir -p $config_fnl
        mkdir -p $out

        cp -r $src/*.fnl $config_fnl

        echo '{}' > "$config_fnl/.nfnl.fnl"

        ${pkgs.neovim}/bin/nvim -u NONE -i NONE --headless -c ":e $config_fnl/.nfnl.fnl" -c ':trust' +q

        ${pkgs.neovim}/bin/nvim -u NONE -i NONE --headless \
            -c "let &runtimepath = &runtimepath . ',${nfnl-root}'" \
            -c "lua require('nfnl.api')['compile-all-files']('$config_fnl')" \
            +q

        for filename in $config_fnl/*.lua
        do
          cp $filename $out
        done
      '';

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
  buildLuaConfig =
    {
      configDir,
      moduleName,
      vars ? null,
      replacements ? null,
      excludeFiles ? [ ],
    }:
    let
      pname = "user-lua-config-${moduleName}";
      luaSrc = builtins.filterSource (
        path: type: (lib.hasSuffix ".lua" path) && !(lib.lists.any (x: baseNameOf path == x) excludeFiles)
      ) configDir;
      compiledFnl = compileNfnl { src = configDir; };

      luaRequires = pkgs.runCommand "luaRequires-${moduleName}" { } ''
        for filename in ${luaSrc}/*.lua ${compiledFnl}/*.lua
        do
          f=$(basename "''${filename}" .lua)
          echo "require'${moduleName}.''${f}'" >> $out
        done
      '';
    in
    (pkgs.stdenv.mkDerivation {
      inherit pname;
      version = "DEV";
      srcs = [ luaSrc ] ++ (lib.optional (compiledFnl != null) compiledFnl);
      unpackPhase = ''
        for _src in $srcs; do
          cp -v $_src/* .
        done
      '';
      installPhase =
        let
          subs = lib.concatStringsSep " " (
            lib.lists.zipListsWith (f: t: "--subst-var-by ${f} ${t}") vars replacements
          );
        in
        ''
          target=$out/lua/${moduleName}
          mkdir -p $target
          cp -r *.lua $target
        ''
        + lib.optionalString (vars != null) ''
          for filename in $target/*
          do
            substituteInPlace $filename ${subs}
          done
        '';
      passthru.luaRequires = builtins.readFile "${luaRequires}";
    });

  my-lua-config = (
    buildLuaConfig {
      configDir = ./config;
      moduleName = "jlle";
      # vars = [ "java.debug.plugin" ];
      # replacements = [ "${nvim-deps.java-debug.jar}" ];
    }
  );

  init-lua = writeText "init.lua" ''
    vim.cmd [[source ${./config/init.vim}]]
    vim.cmd [[source ${./config/sandwich.vim}]]
    ${my-lua-config.luaRequires}
  '';

  startPlugins = with vimPlugins; [
    # vimPlugins.plenary-nvim # not needed, since it will be pulled automatically as a dependency

    nvim-web-devicons
    # TODO
    # https://github.com/ywpkwon/yank-path.nvim

    # if you only want some grammars do
    # (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [ p.python p.java ]))
    nvim-treesitter.withAllGrammars
    rainbow-delimiters-nvim

    # Helpers, needed by other plugins
    popup-nvim
    plenary-nvim
    # sqlite-lua
    # aniseed
    nfnl
    nui-nvim

    # Telescope
    telescope-nvim
    telescope-live-grep-args-nvim
    telescope-file-browser-nvim

    # LSP
    nvim-lspconfig
    # nvim-jdtls
    nvim-metals
    goto-preview
    # (h.neovim.localVimPlugin (vimPluginsDir + /nvim-jdtls))
    nvim-dap
    snacks-nvim
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

    # avante-nvim
    # copilot-vim # Needed for auth
    copilot-lua
    copilot-cmp
    codecompanion-nvim
    wtf-nvim
    # sidekick-nvim

    # UI
    base16-nvim
    # custom-vim-plugs.feline-nvim
    lualine-nvim
    nvim-notify
    nvim-spectre

    # Navigation
    oil-nvim
    # https://github.com/Rolv-Apneseth/tfm.nvim
    vim-unimpaired
    nvim-bqf
    other-nvim

    # Text edition
    vim-repeat
    vim-sandwich
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
    vim-dotenv
    vim-rsi

    # rainbow_parentheses-vim
    # formatter-nvim
    conform-nvim
    nvim-autopairs
    hop-nvim
    vim-gnupg
    harpoon2

    nterm-nvim
    # custom-vim-plugs.nterm-nvim
    baleia-nvim
    # (h.neovim.localVimPlugin (vimPluginsDir + /nterm.nvim))
    # kulala-nvim # TODO Add to nixpkgs

    # Git
    vim-fugitive
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
    vim-nickel
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
    # nvim-paredit
    # vim-sexp
    # vim-sexp-mappings-for-regular-people
    # parpar-nvim
    # nvim-parinfer
    nvim-paredit
    # pkgs.parinfer-rust
    conjure
    # vim-clojure-highlight
    # # vim-kibit
    # # vim-slamhound

    # # Language specific helpers
    # vim-crates
    my-lua-config
  ];
  # ];

  extraDeps = [
    # typescript is needed because it provides the tsserver command.
    # First, it will try to find a tsserver installed with npm install,
    # if not found, it will look in our $PATH
    # See https://github.com/theia-ide/typescript-language-server/blob/a92027377b7ba8b1c9318baad98045e5128baa8e/server/src/lsp-server.ts#L75-L94
    pkgs.nodePackages.typescript
    pkgs.nodePackages.typescript-language-server

    pkgs.nodePackages.bash-language-server
    # Disable it until it gets fixed, uses all your CPU
    # pkgs.nodePackages.vim-language-server
    pkgs.nodePackages.yaml-language-server
    pkgs.dockerfile-language-server

    # Includes css, html and json language server
    # pkgs.vscode-ls
    pkgs.vscode-langservers-extracted

    # Language Servers
    pkgs.clojure-lsp
    pkgs.emmet-language-server
    pkgs.gopls
    pkgs.harper # Grammar checker
    # pkgs.jdt-ls
    pkgs.java-language-server
    pkgs.pyright
    pkgs.rust-analyzer
    pkgs.nls # Nickel
    pkgs.nil # Nix
    # pkgs.nixd
    pkgs.terraform-ls
    pkgs.postgres-language-server

    # Formatters
    pkgs.nodePackages.prettier
    pkgs.black
    (
      let
        config = pkgs.writeText "config.json" ''
          {
            "keywordCase": "upper"
          }
        '';
      in
      pkgs.writeShellApplication {
        name = "sql-formatter";
        runtimeInputs = [
          pkgs.nodePackages.sql-formatter
        ];
        text = ''sql-formatter --config ${config} "$@"'';
      }
    )
    # pkgs.sqlfluff
    # pkgs.pgformatter
    pkgs.nixfmt
    pkgs.rustfmt
    # pkgs.terraform
    pkgs.ormolu
    pkgs.stylua
    pkgs.shfmt
    pkgs.bazel-buildtools

    # Other tools
    pkgs.pspg
    pkgs.shellcheck
  ];

  foldPlugins = builtins.foldl' (
    acc: next:
    acc
    ++ [
      next
    ]
    ++ (foldPlugins (next.dependencies or [ ]))
  ) [ ];

  startPluginsWithDeps = lib.unique (foldPlugins startPlugins);

  packpath = runCommandLocal "packpath" { } ''
    mkdir -p $out/pack/${packageName}/{start,opt}

    ${lib.concatMapStringsSep "\n" (
      plugin: "ln -vsfT ${plugin} $out/pack/${packageName}/start/${lib.getName plugin}"
    ) startPluginsWithDeps}
  '';
in

symlinkJoin {
  name = "nvim";
  paths = [ neovim-unwrapped ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/nvim \
      --add-flags '-u ${init-lua}' \
      --add-flags "--cmd 'set packpath^=${packpath} | set runtimepath^=${packpath}'" \
      --suffix PATH : ${lib.makeBinPath extraDeps} \
      --set-default NVIM_APPNAME nvim-custom
  '';

  passthru = {
    inherit packpath;
  };
}
