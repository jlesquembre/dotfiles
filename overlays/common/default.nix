{}:
self: super: {

  pass = super.pass.override {
    waylandSupport = true;
  };

  # chromium = super.override { enableVaapi = true; };

  # waybar = super.waybar.override {
  #   pulseSupport = true;
  #   withMediaPlayer = true;
  # };

  # firefox = super.firefox.override { gdkWayland = true; };
  # firefox-wayland = super.firefox.override { gdkWayland = true; };

  jdt-ls = super.callPackage ../pkgs/jdt-ls { };

  # For an alternative install method see
  # https://github.com/nix-community/NUR#installation
  # nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") { pkgs = self.pkgs; };

}
