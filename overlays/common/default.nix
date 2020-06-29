{}:
self: super: {
  # nix-freespace = self.callPackage ./extra/nix-freespace.nix { inherit (super); };
  nix-freespace = self.writeScriptBin "nix-freespace" ''
    #!${self.pkgs.bash}/bin/bash
    # Delete everything from this profile that isn't currently needed
    # nix-env --delete-generations old  # --> Not needed (done by nix-collect-garbage)

    # Delete generations older than a week
    nix-collect-garbage --delete-older-than 7d
    sudo nix-collect-garbage --delete-older-than 7d

    # Optimize
    # nix-store --gc --print-dead  # --> Not needed (done by nix-collect-garbage)
    nix-store --optimise
  '';

  babashka = super.babashka.override { graalvm8 = self.graalvm11-ee; };

  clj-kondo =
    let
      pkg = super.clj-kondo.override { graalvm8 = self.graalvm11-ee; };
    in
    pkg.overrideAttrs (oldAttrs: rec {
      pname = "clj-kondo";
      version = "2020.05.09";
      src = self.fetchurl {
        url = "https://github.com/borkdude/${pname}/releases/download/v${version}/${pname}-${version}-standalone.jar";
        sha256 = "07jz18rcj4qlmli28nmc9z0g60ry4kxblpk618dadjn57nnss67z";
      };
    });

  pass = super.pass.override {
    waylandSupport = true;
  };

  waybar = super.waybar.override {
    pulseSupport = true;
    # withMediaPlayer = true;
  };

  firefox = super.firefox.override { gdkWayland = true; };
  firefox-wayland = super.firefox.override { gdkWayland = true; };
}
