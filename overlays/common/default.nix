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

  clap-maple =
    let
      version = "0.20";
    in
    self.rustPlatform.buildRustPackage {
      buildInputs = [ self.openssl ];
      nativeBuildInputs = [ self.pkgconfig ];
      pname = "clap-bin";
      inherit version;

      src = self.fetchzip {
        url = "https://github.com/liuchengxu/vim-clap/archive/v${version}.zip";
        sha256 = "00ql03s95zdv7gibdw0cfz4pg4fhdjfrsmrjkmxizk4hjim93vsp";
      };
      cargoSha256 = "12gv5z22r8s74nmv75d2bxkpn5rscw8sa8xyklqcjjfhgq61xd34";
    };

  # For an alternative install method see
  # https://github.com/nix-community/NUR#installation
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") { pkgs = self.pkgs; };

}
