{ hostName }:
{ config, options, pkgs, lib,  ... }:

let

  mainUser = "jlle";

  secrets = import ../secrets/secrets.nix;

  customEmacs = (import ./emacs.nix { inherit pkgs; });

  customVscode = (import ./vscode.nix { inherit pkgs; });

  # bleeding edge
  #pkgs-unstable = import (fetchTarball https://github.com/nixos/nixpkgs/archive/master.tar.gz) {};

  # unstable channel
  #channel-unstable = import (fetchTarball https://github.com/nixos/nixpkgs-channels/archive/nixos-unstable.tar.gz) {};

  # latest stable channel
  channel-19_09 = import (fetchTarball https://github.com/nixos/nixpkgs-channels/archive/nixos-19.09.tar.gz) {};

  # specific commit
  # pkgs-58d44a3 = import (fetchTarball https://github.com/nixos/nixpkgs/archive/58d44a3.tar.gz) {};

  home-manager = { home-manager-path, config-path }:
    assert builtins.typeOf home-manager-path == "string";
    assert builtins.typeOf config-path == "string";
    (pkgs.callPackage (/. + home-manager-path + "/home-manager") { path = "${home-manager-path}"; }).overrideAttrs (old: {
      nativeBuildInputs = [ pkgs.makeWrapper ];
      buildCommand = ''
        ${old.buildCommand}
        wrapProgram $out/bin/home-manager --set HOME_MANAGER_CONFIG "${config-path}"
      '';
    });

in rec
{

  imports = [
    /etc/nixos/hardware-configuration.nix
    ./cachix.nix
  ]
  ++
    lib.lists.optional (builtins.pathExists ../secrets/nginx/docs/default.nix)  ../secrets/nginx/docs
  ;

  nix.trustedUsers = [ "root" mainUser ];
  nix.useSandbox = true;
  nix.nixPath = [
    "nixpkgs=/home/${mainUser}/nixpkgs"
    "nixos-config=/etc/nixos/configuration.nix"
    "nixpkgs-overlays=/home/${mainUser}/dotfiles/overlays/overlays-compat"
  ];

  networking.hostName = hostName;
  # networking.firewall.enable = false;
  networking.firewall.allowedTCPPorts = [ 8000 8080 ];

  # mount /tmp on tmpfs
  boot.tmpOnTmpfs = true;

  # Select internationalisation properties.
  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  nixpkgs.config.allowUnfree = true;

  # custom packages
  nixpkgs.overlays = [
    (import ../overlays/common {})
  ];
  # nixpkgs.overlays = [
  #   (self: super: {

  #     polybar = super.polybar.override {
  #       i3Support = true;
  #     };

  #     conky = super.conky.override {
  #       lua = self.lua5_3;
  #       luaImlib2Support = false;
  #       luaCairoSupport = false;
  #     };

  #     # okular = super.kdeApplications.okular.overrideDerivation (old: {
  #     #   nativeBuildInputs = old.nativeBuildInputs ++ [ super.makeWrapper ];
  #     #   fixupPhase = ''
  #     #     mv $out/bin/okular $out/bin/okular-unwrapped
  #     #     makeWrapper $out/bin/okular-unwrapped $out/bin/okular --set XDG_CURRENT_DESKTOP KDE
  #     #     '';
  #     #   });

  #   })
  # ];

  # nix.binaryCaches = [
  #   "http://192.168.1.199:8080"
  #   # "https://cache.nixos.org/"
  # ];
  # nix.requireSignedBinaryCaches = false;
  #[ "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs" "nixos-config=/etc/nixos/configuration.nix" "/nix/var/nix/profiles/per-user/root/channels" ]

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    # Custom packages
    nix-freespace

    # Nixpkgs
    abcde
    appimage-run
    arandr
    bat
    bazel bazel-buildtools
    cachix
    calibre
    # conky
    cheat
    chromium google-chrome google-chrome-dev
    # (pkgs.chromium.override { useVaapi = true; })
    clementine
    cmatrix
    cue
    #mpd cantata
    #mopidy mopidy-musicbox-webclient mopidy-moped mopidy-mopify
    docker_compose
    electron
    etcher
    exa
    exiftool
    Fabric
    fd
    file
    firefox
    fish
    fzf
    gcc6
    gettext
    glances
    glxinfo
    gnome3.zenity gnome3.dconf gnome3.dconf-editor
    gnumake
    gnupg blackbox
    go golint # gotools
    graphicsmagick
    gwenview
    # highlight
    htop
    i3lock i3status-rust
    imv
    inkscape
    jetbrains.idea-community
    jump
    just
    jq
    jsonnet
    k3b
    keychain
    # kodi
    kondo
    libffi
    libicns
    # libreoffice-fresh
    libxml2 # Provides xmllint
    lsof
    lzma
    man-db
    mediainfo
    meld
    mlocate
    mmv
    ncdu
    ncurses.dev # infocmp and more utils
    neofetch
    nginxMainline # apacheHttpd # apache used for tools like htpasswd
    noti libnotify
    notify-osd
    ntfs3g
    nushell
    # okular
    libressl
    page
    paper-icon-theme
    pass
    pavucontrol
    pciutils
    pdftk poppler_utils # xpdf
    php
    phpPackages.composer
    prettyping
    proselint
    pwgen
    python3
    ranger
    recoll
    ripgrep ripgrep-all
    rlwrap
    rofi
    rsync
    shellcheck
    shfmt
    smbclient
    sox soxr
    sqlite
    sshfs-fuse
    # super-user-spark
    telnet
    texlive.combined.scheme-full
    tldr
    tmux
    transmission
    tree
    udevil
    unrar
    upower
    # (pkgs.xdg_utils.override { mimiSupport = true; })
    # volnoti
    volumeicon
    w3m
    wget
    # whois # Included in inetutils
    xclip
    # xonsh
    xorg.xkbcomp
    #xorg.xcursorthemes
    youtube-dl
    yubikey-personalization
    zathura

    # nix dev tools
    nixpkgs-review nix-serve nixpkgs-fmt
    direnv niv # lorri installed via the service


    # QT apps helpers
    qt5.qtbase qt5.qtsvg
    breeze-gtk breeze-icons breeze-qt5 gnome-breeze # kde-gtk-config

    # dhall-lang
    dhall dhall-bash dhall-json # dhall-text dhall-nix

    # terminals
    alacritty hyper kitty

    # screenshot utils
    flameshot xfce.xfce4-screenshooter

    # screencasts
    asciinema obs-studio screenkey # kazam recordmydesktop simplescreenrecorder
    kdenlive

    # editors
    neovim neovim-remote vim customVscode customEmacs

    # JS
    nodejs yarn

    # dev tools
    httpstat httplab httping httpie wuzz
    dnsutils tcpdump socat entr watchman # postman
    siege

    # compress tools
    atool zip unzip p7zip dpkg

    # audio/video tools
    ffmpeg-full mpv vlc x265 libopus opusfile opusTools

    # JDK tools
    jdk11 visualvm maven gradle
    mx
    # graalvm11-ee
    (pkgs.graalvm11-ee.overrideAttrs ( attrs: rec{ meta.priority = 1; }))

    # clojure
    clojure leiningen pkgs.boot joker clj-kondo #babashka

    # scala
    bloop sbt

    # purescript
    # purescript psc-package nodePackages.pulp

    # Rust
    rustc cargo rustfmt

    # DB utils
    libmysqlclient mariadb.client
    postgresql pspg # pgcli

    # Kubernetes
    minikube kubectl kubectx kubernetes-helm kustomize pulumi-bin
    # kubectl-fzf
    kubeprompt
    # istioctl
    # gomplate
    google-cloud-sdk
    kind kube3d dapper
    kubeval
    click kube-prompt k9s
    # kubelive
    buildah
    skaffold tilt
    stern

    # Erlang
    erlang elixir

    # Prolog
    gprolog swiPrologWithGui

    # Digital currencies
    monero go-ethereum
    # electrum
  ]
  ++ (with pkgs.gitAndTools; [
    delta
    git-open
    git-recent
    git-trim
    gitFull
    gitRemoteGcrypt
    tig
    transcrypt
  ])
  ++ (with pkgs.nodePackages; [
    bash-language-server
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

  ++ (with pkgs.python38Packages; [
    # cookiecutter
    # csvkit
    ipython
    neovim
    poetry
    virtualenv
  ])
  # ++ (with pkgs.kdeApplications; [
  #   okular
  # ])
  ++ (with haskellPackages; [
    cabal-install
    cabal2nix
    ghc
    # githud
    # stack
    # stack2nix
  ])
  ++ (with channel-19_09; [
    super-user-spark
    haskellPackages.githud
  ])
  ;


  virtualisation.docker.enable = true;
  virtualisation.cri-o.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = false;
  };
  virtualisation.containers.users = [ mainUser ];

  # virtualisation.virtualbox.host = {
  #   enable = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.extraConfig = ''
    AddKeysToAgent yes
  '';

  # Enable GnuPG agent with SSH support
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
  # programs.gnupg.agent.pinentryFlavor = "qt"; # One of "curses", "tty", "gtk2", "qt", "gnome3", "emacs"

  # DNS configuration
  networking.networkmanager.insertNameservers = ["127.0.0.1"];
  # Don't use dns server provided by dhcp server
  networking.dhcpcd.extraConfig = ''
nohook resolv.conf
'';
  services.dnsmasq.enable = true;
  # For dnscrypt use:
  #services.dnsmasq.servers = [ "127.0.0.1#43" ];
  services.dnsmasq.servers = [
    # Cloudflare
    "1.1.1.1"
    "1.0.0.1"

    # OpenDNS
    "208.67.222.222"
    "208.67.220.220"

    # Google
    "8.8.8.8"
    "8.8.4.4"
  ];
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
  services.xserver.displayManager.defaultSession = "none+i3";

  # services.xserver.windowManager.default = "none+i3";
  services.xserver.windowManager.i3.enable = true;

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

  services.devmon.enable = true;
  services.udev.packages = with pkgs; [ libu2f-host yubikey-personalization ];

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    support32Bit = true;
    # extraConfig = ''
    #   # stop switching to HDMI output
    #   unload-module module-switch-on-port-available
    # '';
  };

  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark-qt;


  users.mutableUsers = false;
  users.users.root.hashedPassword = secrets.hashedPassword;

  users.users.${mainUser} = {
    description = "Jose Luis";
    isNormalUser = true;
    home = "/home/${mainUser}";
    hashedPassword = secrets.hashedPassword;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "docker" "cdrom" "wireshark" "mlocate" "dialout"];
    packages = [
      (home-manager {
        home-manager-path = "/home/jlle/home-manager";
        config-path = "/home/jlle/dotfiles/home.nix";
      })
    ];
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      font-awesome-ttf
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
      ttf_bitstream_vera
      ubuntu_font_family
      unifont
    ];
  };

  # locate options
  services.locate = {
    enable = true;
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
  #system.stateVersion = "16.09";

}
