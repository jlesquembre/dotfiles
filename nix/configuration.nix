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
    autojump
    breeze-gtk breeze-icons breeze-qt5 gnome-breeze kde-gtk-config
    # conky
    chromium
    google-chrome-dev
    docker_compose
    electron
    Fabric
    file
    firefox
    fish
    fzf
    gcc6
    glxinfo
    gnome3.zenity
    gnumake
    gnupg
    go
    graphicsmagick
    highlight
    hyper
    i3lock
    keychain
    libicns
    libffi
    libstdcxx5
    lsof
    lzma
    neovim neovim-remote
    nix-repl
    notify-osd
    openssl
    pass
    pavucontrol
    pciutils
    pdftk xpdf
    texlive.combined.scheme-full
    #plasma-integration
    python
    python3
    pwgen
    ranger
    ripgrep
    rofi
    rsync
    sox soxr
    sqlite
    sshfs-fuse
    super-user-spark
    termite
    tmux
    transmission
    tree
    upower
    #(pkgs.xdg_utils.override { mimiSupport = true; })
    vim
    # volnoti
    volumeicon
    wget
    xclip
    xorg.xkbcomp
    #xorg.xcursorthemes
    #pkgs-unstable.hyper

    # JS
    nodejs-7_x yarn

    # dev tools
    httpstat httplab httpie wuzz dnsutils tcpdump

    # compress tools
    atool zip unzip p7zip

    # audio/video tools
    ffmpeg-full mpv vlc x265 libopus opusfile opusTools

    # JDK tools
    jdk visualvm clojure leiningen pkgs.boot
  ]
  ++ (with pkgs.gitAndTools; [
    diff-so-fancy
    git-open
    git-recent
    gitFull
    tig
    transcrypt
  ])
  ++ (with pkgs.nodePackages; [
    node2nix
    prettier
  ])
  ++ (with pkgs.python35Packages; [
    ipython
    neovim
    pgcli
    pygments
    virtualenv
    youtube-dl
  ])
  ++ (with pkgs.kdeApplications; [
    okular
  ])
  ++ (with haskellPackages; [
    ghc
    gitHUD
    stack
  ])
  ;

  # List services that you want to enable:
  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # DNS configuration
  networking.networkmanager.insertNameservers = ["127.0.0.1"];
  services.dnsmasq.enable = true;
  # For dnscrypt use:
  #services.dnsmasq.servers = [ "127.0.0.1#43" ];
  services.dnsmasq.servers = [ "8.8.8.8" "8.8.4.4" "208.67.222.222" "208.67.220.220" ];
  services.dnsmasq.extraConfig = ''
address=/.local/127.0.0.1
'';

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  services.xserver.displayManager.lightdm.enable = true;

  services.xserver.windowManager.default = "i3";
  services.xserver.windowManager.i3.enable = true;

  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;

  services.xserver.desktopManager.plasma5.enable = true;

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.jlle = {
    description = "Jose Luis";
    isNormalUser = true;
    home = "/home/jlle";
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
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
