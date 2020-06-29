{ config, pkgs, lib, ... }:
let
  dotfiles = toString ../dotfiles;
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
  home.stateVersion = "20.09";
  imports = [
    ./custom-options.nix
    ./sway.nix
    ./fish.nix
  ];

  home.packages = with pkgs; [
    clipman
    wl-clipboard
    xfce.ristretto
    ripgrep-all
    gnome3.zenity
  ];

  programs.command-not-found.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "fish";
    BROWSER = "firefox";
    MANPAGER = "nvim -c 'set ft=man' -";
    KUBECTL_EXTERNAL_DIFF = "meld";
  };

  # For debugging config files
  # See https://github.com/rycee/home-manager/issues/257#issuecomment-388146775
  #
  # home.activation.myActivationAction = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   $DRY_RUN_CMD ln -sv $VERBOSE_ARG \
  #       ${builtins.toPath ./dotfiles/foo.txt} $HOME/.config/foo.txt
  # '';

  xdg.enable = true;

  xdg.configFile.chromium = {
    target = "chromium-flags.conf";
    text =
      ''
        --password-store=basic
      '';
  };
  xdg.configFile.chrome = {
    target = "chrome-flags.conf";
    text =
      ''
        # http://peter.sh/experiments/chromium-command-line-switches/
        # https://wiki.archlinux.org/index.php/Chromium/Tips_and_tricks#Making_flags_persistent
        --enable-devtools-experiments
        --password-store=basic
      '';
  };

  xdg.configFile.ranger = {
    source = "${dotfiles}/ranger";
    recursive = true;
  };

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
      # let cljPath = "${dotfiles}/clojure"; in
      replaceStrings
        [ "$HOME" "$CLJ_USER_PATH" ]
        [ "${config.home.homeDirectory}" "${dotfiles}/clojure/src" ]
        (readFile "${dotfiles}/clojure/deps.edn")
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
      # package = pkgs.arc-icon-theme;
      # name = "Arc";
      # package = pkgs.paper-icon-theme;
      # name = "Paper";
      # package = pkgs.numix-icon-theme;
      # name = "Numix";
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
      # package = pkgs.qogir-icon-theme;
      # name = "Qogir";
    };
    theme = {
      package = pkgs.arc-theme;
      name = "Arc";
    };

    # font.name = "Sans Serif 10";
    gtk3.bookmarks = [ "file:///tmp" ];
  };

  xsession.pointerCursor = {
    # package = pkgs.vanilla-dmz;
    # name = "Vanilla-DMZ";
    package = pkgs.qogir-icon-theme;
    name = "Qogir";
    size = 32;
  };

  systemd.user.startServices = true;

  programs.password-store = {
    enable = true;
    settings = lib.mkForce {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
      PASSWORD_STORE_KEY = "E2BA57CA52D5867B";
      PASSWORD_STORE_CLIP_TIME = "60";
    };
  };

  programs.broot = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    # enableNixDirenvIntegration = false;
  };

  programs.fzf = {
    enable = true;

    defaultCommand = "fd --type f --hidden --follow";
    defaultOptions = [ "--height 40% --layout=reverse --border" ];

    # ALT-C
    changeDirWidgetCommand = "fd -t d . $HOME";
    changeDirWidgetOptions = [ "--preview 'fzf_preview_all {}'" ];

    # CTRL-T
    # fileWidgetCommand = "";
    fileWidgetOptions = [ "--preview 'fzf_preview_all {}'" ];

    # CTRL-R
    # historyWidgetOptions = [ "--preview 'echo {}' --preview-window down:3:hidden --bind '?:toggle-preview'" ];
  };

  programs.alacritty = {
    enable = true;
    settings = {
      shell.program = "${pkgs.fish}/bin/fish";
      url.launcher.program = "${pkgs.xdg_utils}/bin/xdg-open";
      mouse.hide_when_typing = false;
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

  programs.mpv = {
    enable = true;
    config = {
      gpu-context = "wayland";

      # Always use 1080p+ or 60 fps where available. Prefer VP9
      # over AVC and VP8 for high-resolution streams.
      ytdl = "yes";
      ytdl-format = "(bestvideo[ext=webm]/bestvideo[height>720]/bestvideo[fps=60])[tbr<13000]+(bestaudio[acodec=opus]/bestaudio[ext=webm]/bestaudio)/best";
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
        # {
        #   publisher = "MS-vsliveshare";
        #   name = "vsliveshare-pack";
        #   version = "0.3.4";
        #   sha256 = "0svijjggycnw9iy7ziiixmcf83p45q0nzvhm0pvcm982hpi4dkra";
        # }
        # {
        #   publisher = "MS-vsliveshare";
        #   name = "vsliveshare";
        #   version = "1.0.2236";
        #   sha256 = "19wxkayf503ingxqnhmy6lb7smwjd2ysd2vg7vayfpd5g3kc0bq8";
        # }
        # {
        #   publisher = "MS-vsliveshare";
        #   name = "vsliveshare-audio";
        #   version = "0.1.85";
        #   sha256 = "0ibhfiimiv6xxri1lw13b5i8vfnnwnjhfm4p5z9aa5yxxcx6rch1";
        # }
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
        {
          publisher = "bierner";
          name = "lit-html";
          version = "1.11.1";
          sha256 = "1qpkxri9ja4lsq7ga99vlg13byfpr5pkh5252wmlfank73mgrpkc";
        }
        {
          publisher = "runem";
          name = "lit-plugin";
          version = "1.1.10";
          sha256 = "0bn9dfbvc639wkjj6hw1mc6qij7m2abwsjzjsw7mhfm64anrw882";
        }
        {
          publisher = "esbenp";
          name = "prettier-vscode";
          version = "5.0.0";
          sha256 = "018n0632gp65b3qwww8ijyb149v8dvbhlys548wvjfax8926jm5j";
        }
        # {
        #   publisher = "sdras";
        #   name = "night-owl";
        #   version = "0.4.1";
        #   sha256 = "1m9n2ny321v2z5x8338p45467i1idic5mha7llslkcyji43q4pyx";
        # }
      ];
    userSettings = {
      # "update.mode" = "none";
      "editor.formatOnSave" = true;
      "[nix]" = {
        "editor.tabSize" = 2;
      };
    };
  };

  # services.vsliveshare = {
  #   enable = true;
  #   extensionsDir = "$HOME/.vscode/extensions";
  #   nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/61cc1f0dc07c2f786e0acfd07444548486f4153b";
  # };

  # programs.browserpass = {
  #   enable = true;
  #   browsers = [ "firefox" ];
  # };

  # programs.firefox = {
  #   enable = true;
  #   #   package = pkgs.firefox-wayland;
  #   profiles = {
  #     default =
  #       {
  #         isDefault = true;
  #         settings = {
  #           "browser.display.background_color" = "#bdbdbd";
  #           "browser.search.hiddenOneOffs" = "Google,Yahoo,Bing,Amazon.com,Twitter";
  #           "browser.search.suggest.enabled" = false;
  #           "browser.startup.page" = 3;
  #           "browser.tabs.closeWindowWithLastTab" = true;
  #           # "browser.urlbar.placeholderName" = "DuckDuckGo";
  #           "devtools.theme" = "dark";
  #           "experiments.activeExperiment" = false;
  #           "experiments.enabled" = false;
  #           "experiments.supported" = false;
  #           "extensions.pocket.enabled" = false;
  #           # "general.smoothScroll" = false;
  #           # "layout.css.devPixelsPerPx" = "1";
  #           # "network.IDN_show_punycode" = true;
  #           # "network.allow-experiments" = false;
  #           # "signon.rememberSignons" = false;
  #           "widget.content.gtk-theme-override" = "Adwaita:light";
  #         };
  #       };
  #   };
  # };

  # services.pasystray.enable = true;

  # fish.functions = {
  #   gitignore = "curl -sL https://www.gitignore.io/api/$argv";
  # };

}
