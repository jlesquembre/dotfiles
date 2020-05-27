# https://developer.gnome.org/pygtk/stable/pango-markup-language.html
{
  layer = "top"; # Waybar at top layer
  position = "bottom"; # Waybar position (top|bottom|left|right)
  height = 32; # Waybar height
  # "width"= 120; # Waybar width
  # Choose the order of the modules
  modules-left = [ "sway/workspaces" "sway/mode" "custom/media" ];
  modules-center = [ "sway/window" ];
  modules-right = [
    "idle_inhibitor"
    "disk"
    "tray"
    "network"
    "cpu"
    "memory"
    #"temperature"
    #"backlight"
    "battery"
    "battery#bat2"
    "pulseaudio"
    "clock"
  ];
  # Modules configuration
  "sway/workspaces" = {
    disable-scroll = false;
    disable-markup = false;
    all-outputs = true;
    "format" = " {name} {icon} ";
    #"format"="{icon}";
    format-icons = {
      "1" = "";
      "2" = "";
      focused = "";
      default = "";
      # focused = "";
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
    format-alt = "{:%Y-%m-%d}";
  };
  cpu = {
    #"format"= "CPU {usage}% "
    format = " {}%";
    states = {
      warning = 60;
      critical = 80;
    };
  };
  memory = {
    interval = 30;
    format = " {used:0.1f}G/{total:0.1f}G ({}%)";
    states = {
      warning = 80;
      critical = 90;
    };
  };
  temperature = {
    # "thermal-zone"= 2;
    # "hwmon-path"= "/sys/class/hwmon/hwmon2/temp1_input";
    critical-threshold = 80;
    # "format-critical"= "{temperatureC}°C ";
    format = "{temperatureC}°C ";
  };
  # "backlight"= {
  #   # "device"= "acpi_video1";
  #   "format"= "{percent}% {icon}";
  #   "states"= [0; 50];
  #   "format-icons"= [""; ""]
  # };
  battery = {
    states = {
      good = 95;
      warning = 30;
      critical = 15;
    };
    format = "{capacity}% {icon}";
    # "format-good"= ""; # An empty format will hide the module
    # "format-full"= "";
    format-icons = [ "" "" "" "" "" ];
  };
  "battery#bat2" = {
    bat = "BAT2";
  };
  disk =
    {
      interval = 30;
      format = "{path} {free}/{total}";
      path = "/";
      states = {
        warning = 30;
        critical = 15;
      };
    };
  network = {
    # "interface"= "wlp2s0"; # (Optional) To force the use of this interface
    format-wifi = ''{essid} {ipaddr} ({signalStrength}%) '';
    format-ethernet = "{ifname}= {ipaddr}/{cidr} ";
    format-disconnected = "Disconnected ⚠";
    interval = 7;
  };
  pulseaudio = {
    scroll-step = 1;
    format = "{volume}% {icon}";
    format-bluetooth = "{volume}% {icon}";
    format-muted = "ﱝ";
    # format-muted = "";
    format-icons = {
      headphones = "";
      handsfree = "";
      headset = "";
      phone = "";
      portable = "";
      car = "";
      default = [ "" "" ];
    };
    on-click = "pavucontrol";
  };

}
