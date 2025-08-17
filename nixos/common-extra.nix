{
  options,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [

    # cue
    # mpd cantata
    # mopidy mopidy-musicbox-webclient mopidy-moped mopidy-mopify
    # electron
    # etcher # ISO writer
    # glances
    # gnome3.zenity gnome3.dconf gnome3.dconf-editor

    # go  golint gotools
    # graphicsmagick
    # gwenview
    # inkscape
    # jetbrains.idea-community
    # libffi
    # libicns
    # libreoffice-fresh
    # okular
    # paper-icon-theme

    # recoll
    # sox
    # soxr
    # udevil
    # unrar
    # upower
    # w3m
    # yubikey-personalization

    # QT apps helpers
    qt5.qtbase
    qt5.qtsvg
    qt5.qtwayland
    # breeze-icons breeze-gtk breeze-qt5 gnome-breeze # kde-gtk-config
  ];

  # services.qemuGuest.enable = true;
  # virtualisation.libvirtd.enable = true;

  # virtualisation.libvirtd = {
  #   enable = true;
  #   # allowedBridges = [
  #   #   "virbr0"
  #   #   "vmbridge"
  #   # ];
  # };

  # virtualisation.docker = {
  #   enable = true;
  #   rootless = {
  #     enable = true;
  #     setSocketVariable = true;
  #   };
  # };

  # virtualisation.containerd.enable = true;

  # virtualisation.cri-o.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = false;
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [
        "--filter=until=24h"
        "--filter=label!=important"
      ];
    };
    dockerSocket.enable = true;

    defaultNetwork.settings = {
      dns_enabled = true;
    };
  };

  programs.sysdig.enable = true;

  services.tumbler.enable = true;

  programs.sniffnet.enable = true;
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark-qt;

  programs.adb.enable = true;

  # Need to setup gnome themes with home-manager
  programs.dconf.enable = true;

  # locate options
  # services.locate = {
  #   enable = false;
  #   # package = pkgs.mlocate;
  #   interval = "hourly";
  #
  #   pruneNames = [
  #     ".git"
  #     "cache"
  #     ".cache"
  #     ".cpcache"
  #     ".aot_cache"
  #     ".boot"
  #     "node_modules"
  #     "USB"
  #   ];
  #
  #   prunePaths = options.services.locate.prunePaths.default ++ [
  #     "/dev"
  #     "/lost+found"
  #     "/nix/var"
  #     "/proc"
  #     "/run"
  #     "/sys"
  #     "/tmp"
  #     "/usr/tmp"
  #     "/var/tmp"
  #   ];
  # };
}
