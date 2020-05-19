{ config, pkgs, ... }:

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
  home.packages = [
    # pkgs.htop
    # pkgs.fortune
  ];

  home.file = {
    editorconfig = {
      source = ./configFiles/editorconfig.ini;
      target = ".editorconfig";
    };
    tigrc = {
      source = ./configFiles/tigrc;
      target = ".tigrc";
    };
    githudrc = {
      source = ./configFiles/githudrc;
      target = ".githudrc";
    };
    psqlrc = {
      source = ./configFiles/psqlrc;
      target = ".psqlrc";
    };
    maven = {
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

  };

  programs = {

    bat.enable = true;
    bat.config = {
      pager = "less -FR";
      # theme = "base16";
      paging = "auto";
    };

    rofi.enable = true;
    rofi.package = pkgs.rofi.override {
      plugins = [
        pkgs.rofi-emoji
        # pkgs.rofi-pass
      ];
    };

    emacs.enable = true;

    git.enable = true;
    git.package = pkgs.gitAndTools.gitFull;
    git.userName = "José Luis Lafuente";
    git.userEmail = "jl@lafuente.me";
    git.extraConfig = {
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
    git.signing = {
      signByDefault = true;
      key = "8A3455EBE455489A";
    };
    git.delta.enable = true;
    git.delta.options = [ "--dark" "--theme base16" "--file-color #ffff00" "--file-style box" ];
    git.aliases = {
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


}
