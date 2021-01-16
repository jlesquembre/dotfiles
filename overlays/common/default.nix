{}:
self: super: {

  pass = super.pass.override {
    waylandSupport = true;
  };

  # chromium = super.override { enableVaapi = true; };

  clipman = super.clipman.overrideAttrs (oldAttrs: rec {
    pname = "clipman";
    version = "unstable-1.5.3";
    src = super.fetchFromGitHub {
      owner = "yory8";
      repo = pname;
      rev = "77706941a34331848f713be356933dc4c269b2fe";
      sha256 = "133ja4kl0sgf86fa4lr8yblp1jf7mn83dp2816cr0jrjh6lwlv3i";
    };
  });

  # waybar = super.waybar.override {
  #   pulseSupport = true;
  #   withMediaPlayer = true;
  # };

  # firefox = super.firefox.override { gdkWayland = true; };
  # firefox-wayland = super.firefox.override { gdkWayland = true; };

  jdt-ls = super.callPackage ../pkgs/jdt-ls { };

  # For an alternative install method see
  # https://github.com/nix-community/NUR#installation
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") { pkgs = self.pkgs; };

}
