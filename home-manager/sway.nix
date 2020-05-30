{ config, pkgs, lib, ... }:
let
  customKeyboardName = "isodev";

  waybarConfig = pkgs.writeTextFile {
    name = "waybar.config";
    text = builtins.toJSON (import ./waybar.nix { pkgs = pkgs; });
  };

  waybarStyle = ../dotfiles/waybar.css;

  makoConfig = pkgs.writeTextFile {
    name = "mako.config";
    text = ''
      background-color=#285577FF
      # time in milliseconds
      default-timeout=5000
    '';
  };

  kanshiConfig = pkgs.writeTextFile {
    name = "kanshi_config";
    text = ''
      profile {
        output eDP-1 disable
        output HDMI-A-2 position 0,0
      }
    '';
    destination = "/kanshi/config";
  };

  volume-sh = pkgs.writeScriptBin "volume.sh"
    ''
      #!${pkgs.bash}/bin/bash

      set -eu

      PATH="${pkgs.pamixer}/bin/:${pkgs.volnoti}/bin/"

      CURVOL=$(pamixer --get-volume)
      incr=5
      NEWVOL=$(($CURVOL + $incr))

      if [ $CURVOL -ge 100 ] && [ "$1" = "up" ]; then
          # Don't go up!
          incr=0
      fi

      if [ "$1" = "toogle" ]; then
        pamixer --toggle-mute
      elif [ "$1" = "up" ]; then
        pamixer --increase $incr
      else
        pamixer --decrease $incr
      fi

      if [ "$(pamixer --get-volume-human)" = "muted" ]; then
        volnoti-show -m $CURVOL
      else
        volnoti-show $CURVOL
      fi
    '';
in
{
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    extraSessionCommands = ''
      export MOZILLLA=1
    '';
    # systemdIntegration = false;
    # package = swayPackage;
    # wrapperFeatures.gtk = true;
    config.modifier = "Mod4";
    config.fonts = [ "Hack 10" ];
    config.window.titlebar = true;
    config.floating.titlebar = true;
    # config.assigns = {
    #   "1: web" = [{ class = "^Firefox$"; }];
    #   # "0: extra" = [{ class = "^Firefox$"; window_role = "About"; }];
    # };
    config.workspaceAutoBackAndForth = true;
    config.workspaceLayout = "tabbed"; # one of "default", "stacked", "tabbed"
    config.terminal = "${pkgs.alacritty}/bin/alacritty";
    config.input = {
      "type:keyboard" = { xkb_layout = customKeyboardName; };
    };
    config.startup = [
      # { command = "systemctl --user restart polybar"; always = true; notification = false; }
      # { command = "dropbox start"; notification = false; }
      { command = "firefox"; }
      { command = "alacritty"; }
    ];
    config.window.commands =
      [
        { command = ''floating enable''; criteria = { app_id = "zenity"; }; }
        { command = ''title_format "%title :: %shell"''; criteria = { shell = ".*"; }; }
      ];
    config.keybindings =
      let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
      lib.mkOptionDefault {
        "${modifier}+space" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+0" = "workspace 10";
        "${modifier}+Shift+0" = "move container to workspace number 10";
        # bindsym --to-code Mod4+space focus mode_toggle
        # bindsym --to-code Mod4+Shift+space floating toggle
        # "${modifier}+Shift+Space" = "exec ${pkgs.kitty}/bin/kitty";
        # "${modifier}+Shift+q" = "kill";
        # "${modifier}+d" = "exec ${pkgs.dmenu}/bin/dmenu_path | ${pkgs.dmenu}/bin/dmenu | ${pkgs.findutils}/bin/xargs swaymsg exec --";
        "${modifier}+d" = "exec ${pkgs.wofi}/bin/wofi --show run";
        "${modifier}+Shift+s" = "exec \"swaylock -f -c 000000 && systemctl suspend\"";
        "${modifier}+Shift+b" = "exec \"swaylock -f -c 000000\"";
        "${modifier}+Shift+o" = ''exec "zenity --question --text 'Reboot the system\nAre you sure?' && systemctl reboot"'';
        "${modifier}+Shift+p" = ''exec "zenity --question --text 'Poweroff the system\nAre you sure?' && systemctl poweroff"'';
      };

    config.bars = [ ];
  };

  # wayland.windowManager.sway.config.bars."mybar".command = "${pkgs.waybar}/bin/waybar";
  # Modified keyboard for developers
  # See http://wiki.linuxquestions.org/wiki/List_of_keysyms
  home.file.dev-keyboard = {
    target = ".xkb/symbols/${customKeyboardName}";
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

  xdg.configFile."wofi/style.css".source = ../dotfiles/wofi.css;

  xdg.configFile."waybar/config".source = waybarConfig;
  xdg.configFile."waybar/style.css".source = waybarStyle;
  systemd.user.services = {
    waybar = {
      Unit = {
        Description = pkgs.waybar.meta.description;
        PartOf = [ "graphical-session.target" ];
      };
      Install = {
        WantedBy = [ "sway-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.waybar}/bin/waybar -c ${waybarConfig} -s ${waybarStyle}";
        RestartSec = 3;
        Restart = "always";
      };
    };

    swayidle = {
      Unit = {
        Description = pkgs.swayidle.meta.description;
        PartOf = [ "graphical-session.target" ];
      };
      Install = {
        WantedBy = [ "sway-session.target" ];
      };
      Service = {
        ExecStart = ''
          ${pkgs.swayidle}/bin/swayidle -w \
             timeout 150 'swaylock -elfF -s fill -i ${../nixos-bg.png}' \
             timeout 300 'swaymsg "output * dpms off"' \
             resume 'swaymsg "output * dpms on"' \
             before-sleep 'swaylock -elfF -s fill -i ${../nixos-bg.png}'
        '';
        RestartSec = 3;
        Restart = "always";
      };
    };
  };


  # Easy to find the default config, and the systemd unit is restarted on changes
  xdg.configFile."mako/config".source = makoConfig;
  systemd.user.services.mako =
    {
      Unit = {
        Description = pkgs.mako.meta.description;
        PartOf = [ "graphical-session.target" ];
      };
      Install = {
        WantedBy = [ "sway-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.mako}/bin/mako -c ${makoConfig}";
        RestartSec = 3;
        Restart = "always";
      };
    };


  xdg.configFile."kanshi/config".source = "${kanshiConfig}/kanshi/config";
  systemd.user.services.kanshi = {
    Unit = {
      Description = "Kanshi dynamic display configuration";
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      # WantedBy = [ "graphical-session.target" ];
      WantedBy = [ "sway-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.kanshi}/bin/kanshi";
      RestartSec = 5;
      Restart = "always";
      Environment = "XDG_CONFIG_HOME=${kanshiConfig}";
    };
  };
}
