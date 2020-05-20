{ config, pkgs, lib, ... }:

{
  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;
  # programs.home-manager.path = "\$HOME/home-manager";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "20.03";
  imports = [ ./home/custom-options.nix ];

  home.packages = with pkgs; [
    gnome3.zenity
  ];

  # xdg.configFile."nvim" = {
  #   source = ./configs;
  #   recursive = true;
  # };
  # xdg.configFile."foo.txt".source = ./configFiles/foo.txt;

  xdg.enable = true;

  # For debugging config files
  # See https://github.com/rycee/home-manager/issues/257#issuecomment-388146775
  #
  # home.activation.myActivationAction = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   $DRY_RUN_CMD ln -sv $VERBOSE_ARG \
  #       ${builtins.toPath ./configFiles/foo.txt} $HOME/.config/foo.txt
  # '';

  # home.file = {
  home.file.editorconfig = {
    source = ./configFiles/editorconfig.ini;
    target = ".editorconfig";
  };

  home.file.tigrc = {
    source = ./configFiles/tigrc;
    target = ".tigrc";
  };

  home.file.githudrc = {
    source = ./configFiles/githudrc;
    target = ".githudrc";
  };

  # config.psql.historyDir is defined in custom-options.nix
  home.file."${config.psql.historyDir}/.keep".text = "";
  home.file.psqlrc = {
    text = ''
      \set QUIET 1

      \setenv PAGER 'pspg -s 6'
      \set PROMPT1 '%[%033[1m%]%M %n@%/%R%[%033[0m%]%# '
      \set PROMPT2 '[more] %R > '

      \pset null '¤'
      \pset border 2
      \pset linestyle 'unicode'
      \pset unicode_border_linestyle single
      \pset unicode_column_linestyle single
      \pset unicode_header_linestyle double

      -- Show how long each query takes to execute
      \timing

      -- Use best available output format
      \x off

      -- Verbose error reports.
      \set VERBOSITY verbose

      -- Use a separate history file per-database.
      \set HISTFILE ${config.psql.historyDir}/ :DBNAME

      -- If a command is run more than once in a row, only store it once in the
      -- history.
      \set HISTCONTROL ignoredups

      -- Autocomplete keywords (like SELECT) in upper-case, even if you started
      -- typing them in lower case.
      \set COMP_KEYWORD_CASE upper

      \unset QUIET
    '';
    target = ".psqlrc";
  };

  home.file.maven = {
    text = ''
      <settings>
        <servers>
          <server>
            <id>clojars</id>
            <username>jlesquembre</username>
            <password>''${clojars.password}</password>
          </server>
        </servers>
      </settings>
    '';
    target = ".m2/settings.xml";
  };
  # TODO
  # rofi = {
  #   source = ./configFiles/rofi.conf;
  #   target = ".config/rofi/config";
  # };

  # };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.paper-icon-theme;
      name = "Paper";
    };
    theme = {
      package = pkgs.arc-theme;
      name = "Arc";
    };
    # font.name = "Sans Serif 10";

    gtk3.bookmarks = [ "file:///tmp" ];
    # gtk3.extraConfig = {};
  };


  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      # theme = "base16";
      paging = "auto";
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi.override {
      plugins = [
        pkgs.rofi-emoji
        # pkgs.rofi-pass
      ];
    };
  };

  programs.emacs = {
    enable = true;
  };

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "José Luis Lafuente";
    userEmail = "jl@lafuente.me";
    signing = {
      signByDefault = true;
      key = "8A3455EBE455489A";
    };
    extraConfig = {
      core = {
        editor = "nvim";
        hooksPath = ".githooks";
      };
      gui = {
        spellingdictionary = "en_US";
      };
      push = {
        default = "simple";
        followTags = true;
      };
      fetch = {
        prune = true;
      };
      commit = {
        verbose = true;
      };
      "diff \"blackbox\"" =
        {
          textconv = "gpg --use-agent -q --batch --decrypt";
        };
    };
    delta.enable = true;
    delta.options = [ "--dark" "--theme base16" "--file-color #ffff00" "--file-style box" ];
    aliases = {
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit --date=short --all";
      cloner = "clone --recursive";
      lasttag = "describe --tags --abbrev=0";
      lt = "describe --tags --abbrev=0";
      patch = "--no-pager diff --no-color";
      diffmin = "diff --word-diff-regex=.";
      diffword = "diff --word-diff";

      # Pull Request Managment, from https://gist.github.com/gnarf/5406589
      pr = "!f() { git fetch -fu \${2:-$(git remote |grep ^upstream || echo origin)} refs/pull/$1/head:pr/$1 && git checkout pr/$1; }; f";
      pr-clean = "!git for-each-ref refs/heads/pr/* --format='%(refname)' | while read ref ; do branch=\${ref#refs/heads/} ; git branch -D $branch ; done";
      spr = "!f() { git fetch -fu \${2:-$(git remote |grep ^upstream || echo origin)} refs/pull-requests/$1/from:pr/$1 && git checkout pr/$1; }; f";
    };
  };

  programs.zathura = {
    enable = true;
    options = {
      sandbox = "none";
    };
  };
  # fish.functions = {
  #   gitignore = "curl -sL https://www.gitignore.io/api/$argv";
  # };

}
