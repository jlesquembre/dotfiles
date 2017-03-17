# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let hostName = "${lib.fileContents ./hostname}";
in
rec
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
    wget
    vim
    neovim
    gitAndTools.gitFull
    gitAndTools.diff-so-fancy
    tig
    ranger
    termite
    chromium
    fish
    atool
    file
    keychain
    rsync
    autojump
    vlc
    mpv
    upower
    i3lock
    rofi
    # conky
    gnupg
    pass
    pciutils
    glxinfo
    ripgrep
    sqlite
    super-user-spark
    tree
    fzf
    python35Packages.pygments
    volnoti
    volumeicon
    xorg.xkbcomp
    gnome3.zenity
    httpie
    python
    python3
    gnumake
    gcc6
    nodejs-7_x
  ];

  # List services that you want to enable:

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
  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;

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
