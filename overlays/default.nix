{ }:
self: super: {

  tree-sitter-nix-numtide = super.tree-sitter-grammars.tree-sitter-nix.overrideAttrs {
    src = super.fetchFromGitHub {
      owner = "numtide";
      repo = "tree-sitter-nix";
      rev = "3d0173d903e630b6e14d17f1cf79488791379ded";
      hash = "sha256-DFmFRZ47TPr8mgmRyXuHLfkQRmO58m4QyN9OBISb7IE=";
    };
  };

  vimPlugins = super.vimPlugins.extend (
    _: vimSuper:
    let
      nixGrammarPlugin = vimSuper.nvim-treesitter.grammarToPlugin self.tree-sitter-nix-numtide;
      # Filter out old nix grammar and add the new one
      newAllGrammars = (builtins.filter (
        g: (super.lib.getName g) != "vimplugin-nvim-treesitter-grammar-nix"
      ) vimSuper.nvim-treesitter.allGrammars) ++ [ nixGrammarPlugin ];
    in
    {
      nvim-treesitter = vimSuper.nvim-treesitter.overrideAttrs (old: {
        passthru = old.passthru // {
          builtGrammars = old.passthru.builtGrammars // {
            nix = nixGrammarPlugin;
            tree-sitter-nix = nixGrammarPlugin;
          };
          grammarPlugins = old.passthru.grammarPlugins // {
            nix = nixGrammarPlugin;
            tree-sitter-nix = nixGrammarPlugin;
          };
          allGrammars = newAllGrammars;
          # Override withAllGrammars to use the new grammars
          withAllGrammars = old.passthru.withPlugins (_: newAllGrammars);
        };
      });
    }
  );

  # pass = super.pass.override {
  #   waylandSupport = true;
  # };

  # chromium = super.override { enableVaapi = true; };

  # waybar = super.waybar.override {
  #   pulseSupport = true;
  #   withMediaPlayer = true;
  # };

  # firefox = super.firefox.override { gdkWayland = true; };
  # firefox-wayland = super.firefox.override { gdkWayland = true; };

  jdt-ls = super.callPackage ./pkgs/jdt-ls { };
  # Replaced by nodePackages.vscode-langservers-extracted
  vscode-ls = super.callPackage ./pkgs/vscode-ls { };
}
