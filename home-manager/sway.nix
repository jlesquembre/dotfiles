{ config, pkgs, lib, ... }:
let
  customKeyboardName = "isodev";

  kanshiConfig = pkgs.writeTextFile {
    name = "kanshi_config";
    text = ''
      profile {
        output eDP-1 disable
        output HDMI-A-2 position 0,0
      }
      profile {
        output eDP-1 enable position 0,0
      }
      profile {
        output eDP-1 disable
        output "Goldstar Company Ltd LG ULTRAWIDE 0x00003BCB" enable position 0,0
      }
      profile {
        output eDP-1 disable
        output "Goldstar Company Ltd LG HDR 4K 0x0000972A" enable scale 1.7 position 0,0
      }
      profile {
        output eDP-1 disable
        output "Dell Inc. DELL S2722QC 54PYLD3" enable scale 1.5 position 0,0
      }
    '';
    destination = "/kanshi/config";
  };

  pass-menu = pkgs.writeScriptBin "pass-menu"
    ''
      #!/usr/bin/env bash

      shopt -s nullglob globstar

      otp=0
      if [[ $1 == "--otp" ]]; then
        otp=1
        shift
      fi

      prefix=''${PASSWORD_STORE_DIR-~/.password-store}
      password_files=( "$prefix"/**/*.gpg )
      password_files=( "''${password_files[@]#"$prefix"/}" )
      password_files=( "''${password_files[@]%.gpg}" )

      password=$(printf '%s\n' "''${password_files[@]}" | "${pkgs.fuzzel}/bin/fuzzel" -d "$@")

      [[ -n $password ]] || exit

      pass show -c "$password" 2>/dev/null
      # pass otp -c "$password" 2>/dev/null
      if [[ $otp -eq 0 ]]; then
        pass show -c "$password" 2>/dev/null
      else
        pass otp -c "$password" 2>/dev/null
      fi
    '';

  volume-sh = pkgs.writeScriptBin "volume.sh"
    ''
      #!${pkgs.bash}/bin/bash

      set -u

      PATH="${pkgs.pamixer}/bin/:${pkgs.volnoti}/bin/"

      CURVOL=$(pamixer --get-volume)
      incr=5

      if [ "$CURVOL" -ge 100 ] && [ "$1" = "up" ]; then
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
        volnoti-show -m "$CURVOL"
      else
        volnoti-show "$(pamixer --get-volume)"
      fi
    '';

  take-screenshot = pkgs.writeScriptBin "screenshot.sh"
    # TODO use
    # https://github.com/jtheoof/swappy
    ''
      #!${pkgs.bash}/bin/bash

      set -u

      PATH="${pkgs.coreutils}/bin/:${pkgs.sway-contrib.grimshot}/bin/"
      grimshot save area "/tmp/screenshot__''$(date +%F_%H%M%S).png";
    '';

  # https://github.com/grahamc/nixos-config/blob/master/packages/sway-cycle-workspace/cycle-workspace.sh
  cycle-workspace = pkgs.writeScriptBin "cycle-workspace.sh"
    ''
      #!${pkgs.bash}/bin/bash

      set -eu

      PATH="${pkgs.jq}/bin/:$PATH"

      get_outputs() {
        swaymsg -t get_outputs | jq '.[] | .name' | sort
      }

      get_current_output() {
        swaymsg -t get_outputs | jq '.[] | select(.focused==true) | .name'
      }

      get_next_output() {
        all_outputs=$(get_outputs)
        current_output=$(get_current_output)
        printf "%s\n%s\n" "$all_outputs" "$all_outputs" |
          grep -A1 "$current_output" |
          head -n2 |
          tail -n1
      }

      swaymsg move workspace to "$(get_next_output)"
    '';

  # https://github.com/swaywm/sway/issues/4121
  focus-window = pkgs.writeScriptBin "focus-window.sh"
    ''
      #!${pkgs.bash}/bin/bash

      set -eu

      PATH="${pkgs.jq}/bin/:${pkgs.ripgrep}/bin/:${pkgs.gawk}/bin/:$PATH"

      # Get regular windows
      regular_windows=$(swaymsg -t get_tree | jq -r '.nodes[1].nodes[].nodes[] | .. | (.id|tostring) + " " + .name?' | rg -e "[0-9]* ."  )

      # Get floating windows
      floating_windows=$(swaymsg -t get_tree | jq '.nodes[1].nodes[].floating_nodes[] | (.id|tostring) + " " + .name?'| rg -e "[0-9]* ." | tr -d '"')

      enter=$'\n'
      if [[ $regular_windows && $floating_windows ]]; then
        all_windows="$regular_windows$enter$floating_windows"
      elif [[ $regular_windows ]]; then
        all_windows=$regular_windows
      else
        all_windows=$floating_windows
      fi

      # Select window with rofi
      selected=$(echo "$all_windows" | wofi --dmenu -i | awk '{print $1}')

      # Tell sway to focus said window
      swaymsg [con_id="$selected"] focus
    '';

in
{
  home.packages = [
    pkgs.fuzzel
    pkgs.swayimg
  ];

  xdg.configFile."swayimg".text = ''
    window = #111122

    [keys]
    k = prev_file
    j = next_file
  '';

  wayland.windowManager.sway = {
    enable = true;
    package = null;

    # https://github.com/nix-community/home-manager/issues/5311
    checkConfig = false;

    config.modifier = "Mod4";
    config.fonts =
      {
        names = [ "Hack 10" ];
      };
    config.window.titlebar = true;
    config.floating.titlebar = true;
    config.workspaceAutoBackAndForth = true;
    config.workspaceLayout = "tabbed"; # one of "default", "stacked", "tabbed"
    config.terminal = "${pkgs.wezterm}/bin/wezterm";
    config.input = {
      "type:keyboard" = { xkb_layout = customKeyboardName; };
    };
    config.startup = [
      # { command = "GTK_USE_PORTAL=1 firefox"; }
      # { command = "systemctl --user restart polybar"; always = true; notification = false; }
      # { command = "alacritty"; }
    ];
    config.window.commands =
      [
        { command = ''floating enable''; criteria = { app_id = "zenity"; }; }
        {
          # command = ''floating enable, move position 877 450, sticky enable, border none'';
          command = ''floating enable, sticky enable, border normal 3'';
          criteria = { app_id = "firefox"; title = "^Picture-in-Picture$"; };
        }
        {
          command = ''floating enable, sticky enable'';
          criteria = { app_id = "firefox"; title = "Firefox - Sharing Indicator$"; };
        }
        # { command = ''title_format "%title :: %shell"''; criteria = { shell = ".*"; }; }
      ];
    config.keybindings =
      let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
      lib.mkOptionDefault {
        "${modifier}+space" = "exec ${pkgs.wezterm}/bin/wezterm";
        "${modifier}+Shift+space" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+0" = "workspace 10";
        "${modifier}+Shift+0" = "move container to workspace number 10";
        # bindsym --to-code Mod4+space focus mode_toggle
        # bindsym --to-code Mod4+Shift+space floating toggle
        # "${modifier}+Shift+q" = "kill";
        # "${modifier}+d" = "exec ${pkgs.dmenu}/bin/dmenu_path | ${pkgs.dmenu}/bin/dmenu | ${pkgs.findutils}/bin/xargs swaymsg exec --";

        "${modifier}+d" = "exec ${pkgs.fuzzel}/bin/fuzzel";
        # "${modifier}+Shift+s" = "exec \"swaylock -f -c 000000 && systemctl suspend\"";
        "${modifier}+Shift+s" = "exec \"systemctl suspend\"";
        "${modifier}+Shift+b" = "exec \"swaylock -f -c 000000\"";
        "${modifier}+o" = ''exec "zenity --question --text 'Reboot the system\nAre you sure?' && systemctl reboot"'';
        "${modifier}+Shift+o" = ''exec "zenity --question --text 'Poweroff the system\nAre you sure?' && systemctl poweroff"'';

        "${modifier}+y" = "exec --no-startup-id ${cycle-workspace}/bin/cycle-workspace.sh";
        # "${modifier}+o" = "exec --no-startup-id ${focus-window}/bin/focus-window.sh";
        "${modifier}+i" = "exec ${pkgs.wdisplays}/bin/wdisplays";
        "${modifier}+s" = "exec ${pkgs.pavucontrol}/bin/pavucontrol";

        "${modifier}+p" = "exec ${pass-menu}/bin/pass-menu";
        "${modifier}+Shift+p" = "exec ${pass-menu}/bin/pass-menu --otp";

        "${modifier}+u" = "exec ${pkgs.clipman}/bin/clipman pick -t wofi -T'-i'";

        "${modifier}+c" = "exec ${take-screenshot}/bin/screenshot.sh";

        # see https://github.com/grahamc/nixos-config/blob/aef2a2c1b0ca584b2c7c04dfbbd5d2615e3448d8/packages/volume/volume.sh
        "XF86AudioRaiseVolume" = "exec --no-startup-id ${volume-sh}/bin/volume.sh up";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${volume-sh}/bin/volume.sh down";
        "XF86AudioMute" = "exec --no-startup-id ${volume-sh}/bin/volume.sh toogle";
        # "XF86MonBrightnessUp" = "exec @backlight@ up";
        # "XF86MonBrightnessDown" = "exec @backlight@ down";
        # "XF86KbdBrightnessUp" = "exec kbdlight up 20";
        # "XF86KbdBrightnessDown" = "exec kbdlight down 20";
      };

    extraConfig = ''
      seat * hide_cursor 5000
      # seat * keyboard_grouping none
      # seat * xcursor_theme default 24
      seat seat0 xcursor_theme Qogir 32

      include /etc/sway/config.d/*
    '';

    config.bars = [ ];
  };

  # Modified keyboard for developers
  # See http://wiki.linuxquestions.org/wiki/List_of_keysyms
  # NOTE See https://github.com/jtroo/kanata
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

  programs.waybar = {
    enable = true;
    settings = [ (import ./waybar.nix { pkgs = pkgs; }) ];
    style = builtins.readFile ../dotfiles/waybar.css;
    systemd.enable = true;
  };

  # services.poweralertd.enable = true;
  services.udiskie = {
    # needs `udisks2.enable` = true in NixOS config
    enable = true;
    tray = "auto";
  };

  # Makes easier to find the default config, and the systemd unit is restarted on changes
  # xdg.configFile."waybar/config".source = waybarConfig;
  # xdg.configFile."waybar/style.css".source = waybarStyle;
  systemd.user.services = {
    swayidle = {
      Unit = {
        Description = pkgs.swayidle.meta.description;
        PartOf = [ "graphical-session.target" ];
      };
      Install = {
        WantedBy = [ "sway-session.target" ];
      };
      Service = {
        Environment = [
          "PATH=${lib.makeBinPath [ pkgs.bash pkgs.libnotify pkgs.swaylock pkgs.sway ]}"
        ];
        ExecStart = ''
          ${pkgs.swayidle}/bin/swayidle -w \
             timeout 120 'notify-send --icon=${pkgs.paper-icon-theme}/share/icons/Paper/512x512/status/error.png -t 19000 "Lock computer" "Computer will be locked in 30 seconds!"' \
             timeout 140 'notify-send --icon=${pkgs.paper-icon-theme}/share/icons/Paper/512x512/status/error.png -t 19000 "Lock computer" "Computer will be locked in 10 seconds!"' \
             timeout 150 'swaylock -elfF -s fill -i ${../dotfiles/img/nixos-bg.png}' \
             timeout 300 'swaymsg "output * dpms off"' \
             resume 'swaymsg "output * dpms on"' \
             before-sleep 'swaylock -elfF -s fill -i ${../dotfiles/img/nixos-bg.png}'
        '';
        RestartSec = 3;
        Restart = "always";
      };
    };
  };

  services.systembus-notify.enable = true;

  # TODO replace with wired? Also volnoti?
  services.mako = {
    enable = true;
    font = "Hack 14";
    padding = "10";
    margin = "30";
    format = ''<i>%a</i>\n<b>%s</b>\n%b'';
    height = 1500;
    width = 700;
    backgroundColor = "#285577FF";
    defaultTimeout = 10000;
    ignoreTimeout = false;
    anchor = "top-right";
    borderSize = 3;
  };

  systemd.user.services.clipman =
    {
      Unit = {
        Description = pkgs.clipman.meta.description;
        PartOf = [ "graphical-session.target" ];
      };
      Install = {
        WantedBy = [ "sway-session.target" ];
      };
      Service = {
        # Wait for next clipman release
        ExecStart = ''${pkgs.wl-clipboard-rs}/bin/wl-paste --type text --watch ${pkgs.clipman}/bin/clipman store --unix'';
        # ExecStart = ''${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.clipman}/bin/clipman store'';
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


  systemd.user.services.volnoti = {
    Unit = {
      Description = "Volume Notifications";
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      # WantedBy = [ "sway-session.target" ];
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      Restart = "always";
      ExecStart = "${pkgs.volnoti}/bin/volnoti -t 2 -n";
      ExecStop = "${pkgs.procps}/bin/pkill volnoti";
    };
  };

  # systemd.user.services.firefox = {
  #   Unit = {
  #     Description = "Firefox";
  #     After = [ "waybar.service" ];
  #   };
  #   Install = {
  #     WantedBy = [ "sway-session.target" ];
  #   };
  #   Service = {
  #     Type = "simple";
  #     Restart = "no";
  #     ExecStart = "${pkgs.firefox}/bin/firefox";
  #   };
  # };
}
