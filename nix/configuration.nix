# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let

  hostName = "${lib.fileContents ./hostname}";

  # bleeding edge
  #pkgs-unstable = import (fetchTarball https://github.com/nixos/nixpkgs/archive/master.tar.gz) {};

  # unstable channel
  #channel-unstable = import (fetchTarball https://github.com/nixos/nixpkgs-channels/archive/nixos-unstable.tar.gz) {};

  # specific commit
  # pkgs-58d44a3 = import (fetchTarball https://github.com/nixos/nixpkgs/archive/58d44a3.tar.gz) {};

in rec
{


  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      # Import machine-specific configuration files.
      (./machines + "/${hostName}.nix")
    ];

  networking.hostName = "${hostName}";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # mount /tmp on tmpfs
  boot.tmpOnTmpfs = true;

  # Select internationalisation properties.
  i18n = {
  #   consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  nixpkgs.config.allowUnfree = true;

  nix.useSandbox = true;
  nix.nixPath = [
    "nixpkgs=/etc/nixos/nixpkgs"
    "nixos-config=/etc/nixos/configuration.nix"
   ];
  #[ "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs" "nixos-config=/etc/nixos/configuration.nix" "/nix/var/nix/profiles/per-user/root/channels" ]

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    atool
    autojump
    breeze-gtk breeze-icons breeze-qt5 gnome-breeze kde-gtk-config
    # conky
    chromium
    docker_compose
    electron
    file
    firefox
    fish
    fzf
    gcc6
    gitAndTools.diff-so-fancy
    gitAndTools.gitFull
    glxinfo
    gnome3.zenity
    gnumake
    gnupg
    graphicsmagick
    highlight
    httpie
    hyper
    i3lock
    keychain
    libicns
    libstdcxx5
    lsof
    lzma
    mpv
    neovim neovim-remote
    nodejs-7_x
    notify-osd
    pass
    pavucontrol
    #plasma-integration plasma-nm plasma-pa plasma-workspace plasma5.systemsettings
    pciutils
    python
    python3 python35Packages.pygments python35Packages.ipython python35Packages.neovim
    ranger
    ripgrep
    rofi
    rsync
    sqlite
    super-user-spark
    termite
    tig
    tree
    upower
    vim
    vlc
    # volnoti
    volumeicon
    wget
    xorg.xkbcomp
    yarn
    #pkgs-unstable.hyper
  ];

  # List services that you want to enable:
  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.default = "i3";
  services.xserver.windowManager.i3.enable = true;

  services.xserver.desktopManager.plasma5.enable = true;

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.jlle = {
    description = "Jose Luis";
    isNormalUser = true;
    home = "/home/jlle";
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      hack-font
      inconsolata
      ubuntu_font_family
      unifont
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      ttf_bitstream_vera
      dejavu_fonts
      freefont_ttf
      powerline-fonts
      font-awesome-ttf
    ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  #system.stateVersion = "16.09";

}
