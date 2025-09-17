{
  config,
  pkgs,
  lib,
  host-options,
  username,
  ageKeyFile,
  inputs,
  nixpkgs-system,
  rootPath,
  ...
}:
let
  userHome = "/home/${username}";
  ssh-auth-keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO8qwM9dPUwYV7bo3jIJThyxeSLZI8qvHq3e0o75nLIo"
  ];
in

{
  imports = [
    ./common-extra.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_16;

  sops.secrets.nixAccessTokens = {
    mode = "0440";
    group = config.users.groups.keys.name;
  };
  sops.secrets.builder_ssh_key = { };

  nixpkgs.flake.setNixPath = false;

  nix = {
    channel.enable = false;
    extraOptions = ''
      experimental-features = nix-command flakes
      builders-use-substitutes = true
      !include ${config.sops.secrets.nixAccessTokens.path}
    '';
    settings = {
      sandbox = true;
      trusted-users = [
        "root"
        username
      ];
      auto-optimise-store = true;
      # substituters = [ ];
      # trusted-public-keys = [ ];
      # The default at 10 is rarely enough.
      log-lines = 35;
    };

    buildMachines = [
      {
        hostName = "build01.tweag.io";
        maxJobs = 24;
        sshUser = "nix";
        sshKey = config.sops.secrets.builder_ssh_key.path;
        systems = [
          "aarch64-linux"
          "x86_64-linux"
        ];
        supportedFeatures = [
          "benchmark"
          "big-parallel"
          "kvm"
          "nixos-test"
        ];
        publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSU9yamc1UjVRUmI2WDNiNkdvT3N2Q0hrSXpHUGE2SUpKWGRLTDB0SDUyYXcK";
      }
      {
        hostName = "build02.tweag.io";
        maxJobs = 24;
        sshUser = "nix";
        sshKey = config.sops.secrets.builder_ssh_key.path;
        systems = [
          "aarch64-darwin"
          "x86_64-darwin"
        ];
        supportedFeatures = [
          "benchmark"
          "big-parallel"
          "kvm"
          "nixos-test"
        ];
        publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSURRTXltam43YmRITXVGd2dOa2lvaWpQckFVUEpoN0kvOTZMVVZ6SVVHUjcK";
      }
    ];
  };

  # mount /tmp on tmpfs
  boot.tmp.useTmpfs = true;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Select internationalisation properties.
  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs;
    [

      ncurses.dev # infocmp and more utils
      rsync
      alacritty
      ghostty
      neovim
    ]
    ++ (with pkgs.gitAndTools; [
      delta
      git-open
      git-recent
      git-trim
      gitFull
      tig
    ]);

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable GnuPG agent with SSH support
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-gnome3;
  # programs.gnupg.agent.pinentryFlavor = "qt"; # One of "curses", "tty", "gtk2", "qt", "gnome3", "emacs"

  # Enable gnome keyring
  # services.gnome3.gnome-keyring.enable = true;
  # programs.seahorse.enable = true;
  # security.pam.services.gdm.enableGnomeKeyring = true;

  security.polkit = {
    enable = true;
    adminIdentities = [ "unix-user:${username}" ];
    # pkaction to see list of actions
    extraConfig = ''
      polkit.addRule(function(action, subject) {
          if (action.id == "org.freedesktop.systemd1.manage-units" &&
              subject.user == "${username}"
          ) {
              return polkit.Result.YES;
          }
      });
    '';
  };

  # see /etc/pam.d
  security.pam.services = {
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
    alsa.enable = true;
    wireplumber.enable = true;
    # jack.enable = true;
  };
  security.rtkit.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # services.dbus.packages = with pkgs; [ gnome3.dconf ];
  # services.gnome3.gnome-remote-desktop.enable = true;
  services.dbus.implementation = "broker";

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.systembus-notify.enable = true;

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      # mako
      wofi
      wdisplays
      waybar
      swaylock
      swayidle
      # (xwayland.overrideAttrs (attrs: { meta.priority = 1; }))
      kanshi
      xdg-desktop-portal-wlr
      sway-contrib.grimshot
      slurp
      grim
    ];
    wrapperFeatures.gtk = true;
  };

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
    autoSuspend = false;
  };

  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
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

  programs.bash.completion.enable = true;
  programs.fish.enable = true;
  programs.fish.vendor.completions.enable = true;

  # services.devmon.enable = true;
  services.udisks2.enable = true;
  services.udev.packages = with pkgs; [
    libu2f-host
    yubikey-personalization
  ];

  # TODO better users
  # systemd.sysusers.enable

  users.mutableUsers = false;
  users.users.root = {
    hashedPasswordFile = config.sops.secrets.rootPassword.path;
    openssh.authorizedKeys.keys = ssh-auth-keys;
  };

  users.users.${username} = {
    description = "José Luis";
    isNormalUser = true;
    home = userHome;
    hashedPasswordFile = config.sops.secrets.jllePassword.path;
    uid = 1000;
    extraGroups = [
      "wheel"
      "networkmanager"
      # "docker"
      "podman"
      "cdrom"
      "wireshark"
      # "mlocate"
      "dialout"
      "adbusers"
      "libvirtd"
      # sops-nix group
      config.users.groups.keys.name
    ];
    openssh.authorizedKeys.keys = ssh-auth-keys;
  };

  sops.age.keyFile = ageKeyFile;
  sops.defaultSopsFile = rootPath + /sops/secrets.yaml;

  sops.secrets.jllePassword.neededForUsers = true;
  sops.secrets.rootPassword.neededForUsers = true;

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      corefonts
      dejavu_fonts
      font-awesome
      freefont_ttf
      hack-font
      inconsolata
      nerd-fonts.hack
      noto-fonts
      noto-fonts-cjk-sans
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

  # programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
  #   # Add any missing dynamic libraries for unpackaged programs
  #   # here, NOT in environment.systemPackages
  # ];

  # programs.virt-manager.enable = true;
  #
  # virtualisation.libvirtd.enable = true;

  # services.metabase = {
  #   enable = true;
  #   listen.port = 63000;
  #   ssl.enable = false;
  # };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "23.11";
}
