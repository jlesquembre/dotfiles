# https://developer.gnome.org/pygtk/stable/pango-markup-language.html
{ pkgs }:

let
  swaync-client = "${pkgs.swaynotificationcenter}/bin/swaync-client";
in

{
  layer = "top"; # Waybar at top layer
  position = "bottom"; # Waybar position (top|bottom|left|right)
  height = 32; # Waybar height
  # "width"= 120; # Waybar width
  # Choose the order of the modules
  modules-left = [
    "sway/workspaces"
    "sway/mode"
  ];
  # modules-center = [ "sway/window" ];
  modules-right = [
    "idle_inhibitor"
    "disk"
    "network"
    "cpu"
    "memory"
    #"temperature"
    #"backlight"
    "battery"
    "pulseaudio"
    "tray"
    "custom/notification"
    "clock"
  ];

  "custom/notification" = {
    "tooltip" = false;
    "format" = "{icon}";
    "format-icons" = {
      "notification" = "󰅸 ";
      "none" = "󰂜 ";
      "dnd-notification" = "󰅸 ";
      "dnd-none" = "󱏨 ";
      "inhibited-notification" = "󰅸 ";
      "inhibited-none" = "󰂜 ";
      "dnd-inhibited-notification" = "󰅸 ";
      "dnd-inhibited-none" = "󱏨 ";
    };
    "return-type" = "json";
    "exec" = "${swaync-client} -swb";
    "on-click" = "${swaync-client} -t -sw";
    "on-click-right" = "${swaync-client} -d -sw";
    "escape" = true;
  };

  # Modules configuration
  "sway/workspaces" = {
    disable-scroll = false;
    disable-markup = false;
    all-outputs = false;
    "format" = " {name} {icon} ";
    format-icons = {
      "1" = "";
      "2" = "";
      # focused = "";
      default = "";
      focused = "";
      # default = "";
      urgent = "";
    };
  };
  "sway/mode" = {
    format = " {}";
    #"max-length"= 50
  };
  idle_inhibitor = {
    format = "{icon}";
    format-icons = {
      activated = "";
      deactivated = "";
    };
  };
  tray = {
    icon-size = 21;
    spacing = 10;
  };
  clock = {
    tooltip-format = "{:%Y-%m-%d | %H:%M}";
    format-alt = "{:%Y-%m-%d | %H:%M}";
    format = "{:%d %b %H:%M}";
  };
  cpu = {
    #"format"= "CPU {usage}% "
    format = " {}%";
    states = {
      warning = 60;
      critical = 80;
    };
    on-click = "";
  };
  memory = {
    interval = 30;
    format = " {used:0.1f}G/{total:0.1f}G ({percentage}%)";
    states = {
      warning = 80;
      critical = 90;
    };
    on-click = "";
  };
  # "backlight"= {
  #   # "device"= "acpi_video1";
  #   "format"= "{percent}% {icon}";
  #   "states"= [0; 50];
  #   "format-icons"= [""; ""]
  # };
  battery = {
    states = {
      # good = 95;
      warning = 30;
      critical = 15;
    };
    format = "{capacity}% {icon}";
    # "format-good"= ""; # An empty format will hide the module
    # "format-full"= "";
    format-icons = [
      ""
      ""
      ""
      ""
      ""
    ];
    # "🔌" # (AC power plug UTF-8 glyph)
    # status_bat = "🔋" (Battery glyph)
    on-click = "";
  };

  disk = {
    interval = 30;
    format = "{path} {free}/{total}";
    path = "/";
    states = {
      warning = 90;
      critical = 95;
    };
    on-click = "";
  };
  network = {
    # "interface"= "wlp2s0"; # (Optional) To force the use of this interface
    format-wifi = ''{essid} {ipaddr} ({signalStrength}%) '';
    format-ethernet = " {ipaddr}/{cidr}";
    format-disconnected = "Disconnected ⚠";
    tooltip-format = "{ifname}";
    interval = 7;
    on-click = "";
  };
  pulseaudio = {
    scroll-step = 1;
    format = "{volume}% {icon}";
    format-bluetooth = "{volume}% {icon}";
    # format-muted = "ﱝ";
    format-muted = "{volume}% 🔇";
    # format-muted = "";
    format-icons = {
      headphones = "";
      handsfree = "";
      headset = "";
      phone = "";
      portable = "";
      car = "";
      default = [
        ""
        ""
      ];
    };
    on-click-middle = "${pkgs.pamixer}/bin/pamixer --toggle";
    on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
  };
}
