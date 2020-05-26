{ config, pkgs, lib, ... }:
let
  dotfiles = ../dotfiles;
in
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
  imports = [
    ./custom-options.nix
    ./sway.nix
  ];

  home.packages = with pkgs; [
    gnome3.zenity
  ];

  # xdg.configFile."nvim" = {
  #   source = ./configs;
  #   recursive = true;
  # };
  # xdg.configFile."foo.txt".source = ./dotfiles/foo.txt;

  xdg.enable = true;

  # For debugging config files
  # See https://github.com/rycee/home-manager/issues/257#issuecomment-388146775
  #
  # home.activation.myActivationAction = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   $DRY_RUN_CMD ln -sv $VERBOSE_ARG \
  #       ${builtins.toPath ./dotfiles/foo.txt} $HOME/.config/foo.txt
  # '';

  # home.file = {
  home.file.editorconfig = {
    source = "${dotfiles}/editorconfig.ini";
    target = ".editorconfig";
  };

  home.file.tigrc = {
    source = "${dotfiles}/tigrc";
    target = ".tigrc";
  };

  home.file.githudrc = {
    source = "${dotfiles}/githudrc";
    target = ".githudrc";
  };

  home.file.clojure = {
    target = ".clojure/deps.edn";
    text = (
      with builtins;
      let cljPath = toString ./clojure; in
      replaceStrings [ "$HOME" "$CLJ_PATH" ] [ "${config.home.homeDirectory}" cljPath ] (readFile "${dotfiles}/deps.edn")
    );
  };

  # NixOS already manage gpg-agent per user, add only some extra config
  # If home-manager manages it, you need to setup some services with NixOS at
  # system level anyways:
  # services.dbus.packages = with pkgs; [ pkgs.gcr gnome3.dconf]
  home.file.".gnupg/sshcontrol" = {
    text = ''
      04DC5CE6C1FCA557E5CDE3C1EA40496D37F50891
    '';
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

  systemd.user.startServices = true;

  programs.alacritty = {
    enable = true;
    settings = {
      shell.program = "${pkgs.fish}/bin/fish";
      url.launcher.program = "${pkgs.xdg_utils}/bin/xdg-open";
      cursor.style = "Block";
      window = {
        padding = {
          x = 5;
          y = 5;
        };
      };
      font = {
        family = "Hack";
        size = 12.0;
      };
      key_bindings = [
        {
          key = "Q";
          mods = "Control";
          action = "SpawnNewInstance";
        }
        {
          key = "L";
          mods = "Control";
          action = "ReceiveChar";
        }
      ];
      colors = {
        primary =
          {
            background = "#0f1419";
            foreground = "#d8d8d8";
          };
        cursor =
          {
            text = "#000000";
            cursor = "#d8d8d8";
          };
        normal =
          {
            black = "#181818";
            red = "#ab4642";
            green = "#a1b56c";
            yellow = "#f7ca88";
            blue = "#7cafc2";
            magenta = "#ba8baf";
            cyan = "#86c1b9";
            white = "#d8d8d8";
          };
        bright =
          {
            black = "#585858";
            red = "#ab4642";
            green = "#a1b56c";
            yellow = "#f7ca88";
            blue = "#7cafc2";
            magenta = "#ba8baf";
            cyan = "#86c1b9";
            white = "#d8d8d8";
          };
      };
    };
  };

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      # theme = "base16";
      paging = "auto";
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

  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    extensions =
      with pkgs.vscode-extensions; [
        bbenoist.Nix
        ms-azuretools.vscode-docker
        ms-kubernetes-tools.vscode-kubernetes-tools
        ms-vscode.Go
        ms-vscode-remote.remote-ssh
        ms-python.python
        redhat.vscode-yaml
        vscodevim.vim
      ]
      # Concise version from the vscode market place when not available in the default set.
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          publisher = "MS-vsliveshare";
          name = "vsliveshare-pack";
          version = "0.3.4";
          sha256 = "0svijjggycnw9iy7ziiixmcf83p45q0nzvhm0pvcm982hpi4dkra";
        }
        {
          publisher = "MS-vsliveshare";
          name = "vsliveshare";
          version = "1.0.2236";
          sha256 = "19wxkayf503ingxqnhmy6lb7smwjd2ysd2vg7vayfpd5g3kc0bq8";
        }
        {
          publisher = "MS-vsliveshare";
          name = "vsliveshare-audio";
          version = "0.1.85";
          sha256 = "0ibhfiimiv6xxri1lw13b5i8vfnnwnjhfm4p5z9aa5yxxcx6rch1";
        }
        {
          publisher = "vscjava";
          name = "vscode-java-pack";
          version = "0.9.0";
          sha256 = "0yvbxlflz5gx2i16kjh4mg64z8138rh0ck8n986hf66gjr7vv89m";
        }
        {
          publisher = "ms-vscode-remote";
          name = "remote-containers";
          version = "0.117.1";
          sha256 = "0kq3wfwxjnbhbq1ssj7h704gvv1rr0vkv7aj8gimnkj50jw87ryd";
        }
        # {
        #   publisher = "sdras";
        #   name = "night-owl";
        #   version = "0.4.1";
        #   sha256 = "1m9n2ny321v2z5x8338p45467i1idic5mha7llslkcyji43q4pyx";
        # }
      ];
  };

  programs.firefox = {
    enable = true;
    # package = pkgs.firefox-wayland;
  };

  wayland.windowManager.sway = {
    enable = true;
    extraSessionCommands =
      ''
        export SDL_VIDEODRIVER=wayland
        # needs qt5.qtwayland in systemPackages
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        # Fix for some Java AWT applications (e.g. Android Studio),
        # use this if they aren't displayed properly:
        export _JAVA_AWT_WM_NONREPARENTING=1
        MOZ_ENABLE_WAYLAND = "1";
        # XCURSOR_PATH = [ "${pkgs.gnome3.adwaita-icon-theme}/share/icons" ];
      '';
    wrapperFeatures.gtk = true;
    # extraOptions =  [ "--verbose" "--debug" "--unsupported-gpu" "--my-next-gpu-wont-be-nvidia" ];
    config.modifier = "Mod4";
    config.fonts = [ "Hack 10" ];
    config.window.titlebar = true;
    config.assigns = {
      "1: web" = [{ class = "^Firefox$"; }];
      # "0: extra" = [{ class = "^Firefox$"; window_role = "About"; }];
    };
    # config.floating.titlebar = true;
    config.workspaceAutoBackAndForth = true;
    config.workspaceLayout = "tabbed"; # one of "default", "stacked", "tabbed"
    # config.terminal = "${pkgs.alacritty}/bin/alacritty";
    # config.input = {
    #   "type:keyboard" = { xkb_variant = "iso-dev"; };
    # };
    config.startup = [
      # { command = "systemctl --user restart polybar"; always = true; notification = false; }
      # { command = "dropbox start"; notification = false; }
      { command = "firefox"; }
    ];
    config.keybindings =
      let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
      lib.mkOptionDefault {
        "${modifier}+Space" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+Shift+Space" = "exec ${pkgs.kitty}/bin/kitty";
        # "${modifier}+Shift+q" = "kill";
        # "${modifier}+d" = "exec ${pkgs.dmenu}/bin/dmenu_path | ${pkgs.dmenu}/bin/dmenu | ${pkgs.findutils}/bin/xargs swaymsg exec --";
      };
  };

  # Modified keyboard for developers
  # See http://wiki.linuxquestions.org/wiki/List_of_keysyms
  home.file.dev-keyboard = {
    target = ".xkb/symbols/iso-dev";
    text = ''
      partial default alphanumeric_keys
      xkb_symbols "basic" {

          name[Group1]="ISO keyboard for developers";

          //include "latin(type4)"
          //include "level3(ralt_switch)"
          include "us(altgr-intl)"
          include "level3(caps_switch)"
          modifier_map  Control { <CAPS>, <LCTL> };

          key <AE01> {[           1,           exclam,      exclamdown,          bar   ]};
          key <AE02> {[           2,               at                                  ]};
          key <AE06> {[           6,      asciicircum                                  ]};

          key <AE07> {[           7,        ampersand                                  ]};
          key <AE08> {[           8,         asterisk                                  ]};
          key <AE09> {[           9,        parenleft                                  ]};
          key <AE10> {[           0,       parenright                                  ]};

          key <AD03> {[           e,                E,        EuroSign,     sterling   ]};
          key <AD09> {[           o,                O,       masculine                 ]};

          key <AC01> {[           a,                A,     ordfeminine                 ]};
          key <AC02> {[           s,                S,          ssharp                 ]};

          key <AC10> {[   semicolon,            colon,  dead_diaeresis                 ]};
          key <AC11> {[  apostrophe,         quotedbl,      dead_acute                 ]};

          key <MENU> {[  dead_acute,   dead_diaeresis                                  ]};
          key <LSGT> {[   backslash,              bar                                  ]};
          key <AB06> {[           n,                N,          ntilde,       Ntilde   ]};
          key <AB07> {[           m,                M,              mu,           mu   ]};
          key <AB08> {[       comma,             less                                  ]};
          key <AB09> {[      period,          greater                                  ]};
          key <AB10> {[       slash,         question,    questiondown,    dead_hook   ]};

          key <CAPS>  {  symbols[Group1]=[ Control_L ] };
      };
    '';
  };





  # fish.functions = {
  #   gitignore = "curl -sL https://www.gitignore.io/api/$argv";
  # };

}