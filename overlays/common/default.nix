{}:
self: super: {

  # pass = super.pass.override {
  #   waylandSupport = true;
  # };

  # chromium = super.override { enableVaapi = true; };

  # waybar = super.waybar.override {
  #   pulseSupport = true;
  #   withMediaPlayer = true;
  # };

  # firefox = super.firefox.override { gdkWayland = true; };
  # firefox-wayland = super.firefox.override { gdkWayland = true; };

  jdt-ls = super.callPackage ../pkgs/jdt-ls { };
  vscode-ls = super.callPackage ../pkgs/vscode-ls { };
}
