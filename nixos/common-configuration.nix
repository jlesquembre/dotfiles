{ config
, options
, pkgs
, lib
, host-options
, username
, ageKeyFile
, inputs
, nixpkgs-system
, rootPath
, ...
}:
let
  userHome = "/home/${username}";
in

rec
{

  sops.secrets.nixAccessTokens = {
    mode = "0440";
    group = config.users.groups.keys.name;
  };
  sops.secrets.builder_ssh_key = { };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      builders-use-substitutes = true
      !include ${config.sops.secrets.nixAccessTokens.path}
    '';
    settings = {
      sandbox = true;
      trusted-users = [ "root" username ];
      auto-optimise-store = true;
      substituters = [
        "https://jl-nix.cachix.org"
      ];
      trusted-public-keys = [
        "jl-nix.cachix.org-1:lHxA3Z7QoYjxFczo138tIzUHQvJP41rMNgYmBfEBdMU="
      ];
    };
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "build01.tweag.io";
        maxJobs = 24;
        sshUser = "nix";
        sshKey = config.sops.secrets.builder_ssh_key.path;
        system = "x86_64-linux";
        supportedFeatures = [ "benchmark" "big-parallel" "kvm" ];
        publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSU9yamc1UjVRUmI2WDNiNkdvT3N2Q0hrSXpHUGE2SUpKWGRLTDB0SDUyYXcK";
      }
      {
        hostName = "build02.tweag.io";
        maxJobs = 24;
        sshUser = "nix";
        sshKey = config.sops.secrets.builder_ssh_key.path;
        systems = [ "aarch64-darwin" "x86_64-darwin" ];
        supportedFeatures = [ "benchmark" "big-parallel" ];
        publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSURRTXltam43YmRITXVGd2dOa2lvaWpQckFVUEpoN0kvOTZMVVZ6SVVHUjcK";
      }
    ];
  };
  nixpkgs.config.allowUnfree = true;

  # mount /tmp on tmpfs
  boot.tmpOnTmpfs = true;

  # Select internationalisation properties.
  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    abcde
    appimage-run
    arandr
    # bat
    # bazel bazel-buildtools
    cachix
    caddy
    # calibre
    cntr
    cheat
    cmatrix
    # cue
    # mpd cantata
    # mopidy mopidy-musicbox-webclient mopidy-moped mopidy-mopify
    # electron
    # etcher # ISO writer
    exiftool
    file
    firefox-wayland
    fish
    fzf
    gcc6
    # glances
    glxinfo
    # gnome3.zenity gnome3.dconf gnome3.dconf-editor
    gnumake

    # go  golint gotools
    graphicsmagick
    gwenview
    htop
    # imv
    inkscape
    # jetbrains.idea-community
    # jump
    just
    jq
    keychain
    # kodi
    kondo
    libffi
    libicns
    # libreoffice-fresh
    libxml2 # Provides xmllint
    lsof
    man-db
    mediainfo
    meld
    mlocate
    mmv
    ncdu
    ncurses.dev # infocmp and more utils
    neofetch
    nginxMainline # apacheHttpd # apache used for tools like htpasswd
    noti
    libnotify
    notify-osd
    ntfs3g
    # okular
    libressl
    page
    # paper-icon-theme
    pass
    pavucontrol
    pciutils
    pdftk
    poppler_utils # xpdf
    prettyping
    proselint
    pwgen
    python3
    ranger
    recoll
    rlwrap
    rsync
    shellcheck
    shfmt
    # samba
    sox
    soxr
    sqlite
    sshfs-fuse
    texlive.combined.scheme-full
    tldr
    tmux
    transmission
    tree
    udevil
    unrar
    upower
    w3m
    wget
    xz
    youtube-dl
    yubikey-personalization

    # QT apps helpers
    qt5.qtbase
    qt5.qtsvg
    qt5.qtwayland
    # breeze-icons breeze-gtk breeze-qt5 gnome-breeze # kde-gtk-config

    # terminals
    alacritty
    kitty # hyper

    # encryption
    age
    blackbox
    gnupg
    magic-wormhole-rs
    pkgs.sops

    # screenshot utils
    flameshot
    xfce.xfce4-screenshooter

    # screencasts
    asciinema
    obs-studio
    screenkey # kazam recordmydesktop simplescreenrecorder
    kdenlive

    # editors
    neovim
    neovim-remote
    vim

    # JS
    nodejs

    # compress tools
    atool
    zip
    unzip
    unar
    dpkg
    libarchive # replaces p7zip: bsdtar -cf archive.7z --format=7zip ...

    # audio/video tools
    ffmpeg-full
    mpv
    vlc
    x265
    libopus
    opusfile
    opusTools

    # scala
    # bloop sbt

    # DB utils
    postgresql
    pspg # pgcli
    # libmysqlclient mariadb.client

    inputs.githud.defaultPackage."${nixpkgs-system}"

  ]
  ++ (with pkgs.gitAndTools; [
    delta
    git-open
    git-recent
    git-trim
    gitFull
    tig
  ])
  ++ (with pkgs.nodePackages; [
    fkill-cli
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

  ++ (with pkgs.python39Packages; [
    ipython
  ])
  ;


  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };

  virtualisation.containerd.enable = true;

  virtualisation.cri-o.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = false;
  };

  programs.sysdig.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable GnuPG agent with SSH support
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
  # programs.gnupg.agent.pinentryFlavor = "qt"; # One of "curses", "tty", "gtk2", "qt", "gnome3", "emacs"

  # Enable gnome keyring
  # services.gnome3.gnome-keyring.enable = true;
  # programs.seahorse.enable = true;
  # security.pam.services.gdm.enableGnomeKeyring = true;

  # see /etc/pam.d
  security.pam.services =
    {
      # see
      # https://github.com/cruegge/pam-gnupg
      # https://github.com/NixOS/nixpkgs/pull/97726
      login.gnupg = {
        enable = true;
        storeOnly = true;
        # noAutostart = true;
      };
      gdm.gnupg = {
        enable = true;
        storeOnly = true;
      };
      swaylock.gnupg.enable = true;
    };


  services.pipewire = {
    enable = true;
    pulse.enable = true;
    # jack.enable = true;
  };
  security.rtkit.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };


  # services.dbus.packages = with pkgs; [ gnome3.dconf ];
  # services.gnome3.gnome-remote-desktop.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.sway =
    {
      enable = true;
      extraPackages = with pkgs; [
        mako
        wofi
        wdisplays
        waybar
        swaylock
        swayidle
        (xwayland.overrideAttrs (attrs: { meta.priority = 1; }))
        kanshi
        xdg-desktop-portal-wlr
        sway-contrib.grimshot
        slurp
        grim
      ];
      wrapperFeatures.gtk = true;
    };
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  # services.xserver.desktopManager.session = [
  services.xserver.displayManager.session = [
    {
      name = "xterm";
      manage = "desktop";
      start = ''
        ${pkgs.xterm}/bin/xterm -ls &
        waitPID=$!
      '';
    }
  ];

  services.tumbler.enable = true;


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # services.xserver.windowManager.xmonad.enable = true;
  # services.xserver.windowManager.xmonad.enableContribAndExtras = true;

  # services.xserver.desktopManager.plasma5.enable = true;

  # Use dconf-editor to see all settings, or see:
  # https://github.com/GNOME/gtk/blob/master/gtk/org.gtk.Settings.FileChooser.gschema.xml
  # environment.extraOutputsToInstall = ["dev"];
  # services.xserver.desktopManager.gnome3.enable = true;
  # services.xserver.desktopManager.gnome3.extraGSettingsOverrides = ''
  # [org.gtk.Settings.FileChooser]
  # sort-directories-first=true
  # '';

  programs.bash.enableCompletion = true;
  programs.fish.enable = true;
  programs.fish.vendor.completions.enable = true;

  # services.devmon.enable = true;
  services.udisks2.enable = true;
  services.udev.packages = with pkgs; [ libu2f-host yubikey-personalization ];

  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark-qt;

  programs.adb.enable = true;

  users.mutableUsers = false;
  users.users.root.passwordFile = config.sops.secrets.rootPassword.path;

  users.users.${username} = {
    description = "José Luis";
    isNormalUser = true;
    home = userHome;
    passwordFile = config.sops.secrets.jllePassword.path;
    uid = 1000;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "cdrom"
      "wireshark"
      "mlocate"
      "dialout"
      "adbusers"
      # sops-nix group
      config.users.groups.keys.name
    ];
  };

  sops.age.keyFile = ageKeyFile;
  sops.defaultSopsFile = rootPath + /sops/secrets.yaml;

  sops.secrets.jllePassword.neededForUsers = true;
  sops.secrets.rootPassword.neededForUsers = true;

  # TODO move to home-manager
  # See
  # https://github.com/Mic92/sops-nix/issues/62
  sops.secrets.ssh-config = {
    owner = username;
    path = "${userHome}/.ssh/config";
    format = "binary";
    sopsFile = rootPath + /sops/ssh_config;
  };

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      font-awesome
      freefont_ttf
      hack-font
      inconsolata
      (nerdfonts.override {
        fonts = [
          "Hack"
        ];
      })
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      powerline-fonts
      roboto
      roboto-mono
      roboto-slab
      source-code-pro
      ttf_bitstream_vera
      ubuntu_font_family
      unifont
    ];
  };


  # Need to setup gnome themes with home-manager
  programs.dconf.enable = true;

  # locate options
  services.locate = {
    enable = false;
    locate = pkgs.mlocate;
    localuser = null; # mlocate does not support this option so it must be null
    # interval = "daily";
    interval = "hourly";

    pruneNames = [
      ".git"
      "cache"
      ".cache"
      ".cpcache"
      ".aot_cache"
      ".boot"
      "node_modules"
      "USB"
    ];

    prunePaths = options.services.locate.prunePaths.default ++ [
      "/dev"
      "/lost+found"
      "/nix/var"
      "/proc"
      "/run"
      "/sys"
      "/tmp"
      "/usr/tmp"
      "/var/tmp"
    ];
  };


  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "22.05";

  # My initial version:
  #system.stateVersion = "16.09";

}
