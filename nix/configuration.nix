# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let

  hostName = "${lib.fileContents ./hostname}";

  customNginx = (./nginx + "/${hostName}.nix");

  customEmacs = (import ./emacs.nix { inherit pkgs; });

  # bleeding edge
  #pkgs-unstable = import (fetchTarball https://github.com/nixos/nixpkgs/archive/master.tar.gz) {};

  # unstable channel
  #channel-unstable = import (fetchTarball https://github.com/nixos/nixpkgs-channels/archive/nixos-unstable.tar.gz) {};

  # latest stable channel
  # channel-17_09 = import (fetchTarball https://github.com/nixos/nixpkgs-channels/archive/nixos-17.09.tar.gz) {};

  # specific commit
  # pkgs-58d44a3 = import (fetchTarball https://github.com/nixos/nixpkgs/archive/58d44a3.tar.gz) {};

  customVscode = pkgs.vscode-with-extensions.override {
    # When the extension is already available in the default extensions set.
    vscodeExtensions = with pkgs.vscode-extensions; [
      bbenoist.Nix
    ]
    # Concise version from the vscode market place when not available in the default set.
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vim";
        publisher = "vscodevim";
        version = "0.10.1";
        sha256 = "1ihmq5g9r290rjqqv4g9jfssqvjcr9n1mywmvrd9ii6zx72d3va1";
      }
    ];
  };

in rec
{


  imports =
    [ ./nginx/common.nix
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      # Import machine-specific configuration files.
      (./machines + "/${hostName}.nix")
    ]
    ++ lib.optional (builtins.pathExists customNginx) customNginx;

  networking.hostName = "${hostName}";
  # networking.firewall.enable = false;

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

  # custom packages
  nixpkgs.overlays = [
    (self: super: {

      polybar = super.polybar.override {
        i3Support = true;
      };

      conky = super.conky.override {
        lua = self.lua5_3;
        luaImlib2Support = false;
        luaCairoSupport = false;
      };

      # okular = super.kdeApplications.okular.overrideDerivation (old: {
      #   nativeBuildInputs = old.nativeBuildInputs ++ [ super.makeWrapper ];
      #   fixupPhase = ''
      #     mv $out/bin/okular $out/bin/okular-unwrapped
      #     makeWrapper $out/bin/okular-unwrapped $out/bin/okular --set XDG_CURRENT_DESKTOP KDE
      #     '';
      #   });

    })
  ];

  nix.useSandbox = true;
  nix.nixPath = [
    "nixpkgs=/etc/nixos/nixpkgs"
    "nixos-config=/etc/nixos/configuration.nix"
   ];
  #[ "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs" "nixos-config=/etc/nixos/configuration.nix" "/nix/var/nix/profiles/per-user/root/channels" ]

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    abcde
    autojump
    # breeze-gtk breeze-icons breeze-qt5 gnome-breeze kde-gtk-config
    # conky
    cheat
    chromium
    clementine
    cmatrix
    #mpd cantata
    #mopidy mopidy-musicbox-webclient mopidy-moped mopidy-mopify
    google-chrome-dev
    docker_compose
    electron
    exa
    Fabric
    fd
    file
    firefox-bin
    fish
    fzf
    gcc6
    glxinfo
    gnome3.zenity gnome3.dconf gnome3.dconf-editor
    gnumake
    gnupg
    go
    graphicsmagick
    gwenview
    highlight
    htop
    hyper
    i3lock i3status-rust
    k3b
    keychain
    kitty
    libffi
    libicns
    libstdcxx5
    lsof
    lzma
    mcomix
    mediainfo
    neofetch
    nginxMainline
    nix-repl
    notify-osd libnotify
    ntfs3g
    # okular
    openssl
    paper-icon-theme arc-theme
    pass
    pavucontrol
    pciutils
    pdftk xpdf
    php
    php71Packages.composer
    proselint
    # purescript
    pwgen
    python
    ranger
    recoll
    ripgrep
    rofi
    rsync
    sox soxr
    sqlite
    sshfs-fuse
    super-user-spark
    termite
    texlive.combined.scheme-full
    tldr
    tmux
    transmission
    tree
    udevil
    unrar
    upower
    #(pkgs.xdg_utils.override { mimiSupport = true; })
    # volnoti
    volumeicon
    w3m
    wget
    whois
    xclip
    xorg.xkbcomp
    #xorg.xcursorthemes
    zathura

    # screenshot utils
    flameshot simplescreenrecorder xfce.xfce4-screenshooter

    # editors
    neovim neovim-remote vim customVscode customEmacs

    # JS
    nodejs-8_x yarn

    # dev tools
    httpstat httplab httpie wuzz dnsutils tcpdump socat

    # compress tools
    atool zip unzip p7zip

    # audio/video tools
    ffmpeg-full mpv vlc x265 libopus opusfile opusTools

    # JDK tools
    jdk visualvm clojure leiningen pkgs.boot joker

    # Rust
    rustc cargo rustfmt

    # DB utils
    libmysql postgresql pgcli

    # Digital currencies
    electrum monero go-ethereum
  ]
  ++ (with pkgs.gitAndTools; [
    diff-so-fancy
    git-open
    git-recent
    gitRemoteGcrypt
    gitFull
    tig
    transcrypt
  ])
  ++ (with pkgs.nodePackages; [
    bower
    node2nix
    prettier
  ])

  # Extra packages added to the global python environment, see
  # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.md#installing-python-and-packages
  # ++ (with pkgs; [(python3.withPackages(ps: with ps; [
    # cookiecutter
    # ipython
    # jupyter
    # pygments
  # ]))])

  ++ (with pkgs.python36Packages; [
    cookiecutter
    glances
    ipython
    neovim
    pygments
    virtualenv
    youtube-dl
  ])
  # ++ (with pkgs.kdeApplications; [
  #   okular
  # ])
  ++ (with haskellPackages; [
    cabal-install
    cabal2nix
    ghc
    gitHUD
    stack
    stack2nix
  ])
  # ++ (with channel-17_09; [
  #   super-user-spark
  # ])
  ;

  # List services that you want to enable:
  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.extraConfig = ''
    AddKeysToAgent yes
  '';

  # Enable GnuPG agent with SSH support
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  # DNS configuration
  networking.networkmanager.insertNameservers = ["127.0.0.1"];
  # Don't use dns server provided by dhcp server
  networking.dhcpcd.extraConfig = ''
nohook resolv.conf
'';
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

  # services.xserver.desktopManager.plasma5.enable = true;

  # Use dconf-editor to see all settings, or see:
  # https://github.com/GNOME/gtk/blob/master/gtk/org.gtk.Settings.FileChooser.gschema.xml
  services.xserver.desktopManager.gnome3.extraGSettingsOverrides = ''
[org.gtk.Settings.FileChooser]
sort-directories-first=true
'';

  programs.bash.enableCompletion = true;
  programs.fish.enable = true;
  programs.fish.vendor.completions.enable = true;

  services.devmon.enable = true;
  services.udev.packages = with pkgs; [ libu2f-host ];

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark-qt;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.jlle = {
    description = "Jose Luis";
    isNormalUser = true;
    home = "/home/jlle";
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "docker" "cdrom" "wireshark" ];
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
