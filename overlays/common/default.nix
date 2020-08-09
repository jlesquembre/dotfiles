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

  babashka-bin =
    let
      version = "0.1.3";
    in
    self.stdenv.mkDerivation {
      inherit version;
      pname = "babashka-bin";
      dontBuild = true;
      installPhase = ''
        mkdir -p $out/bin
        cp bb $out/bin
      '';
      src = self.fetchzip {
        url = "https://github.com/borkdude/babashka/releases/download/v${version}/babashka-${version}-linux-static-amd64.zip";
        sha256 = "0jxxryx5a0jv405i3ch9n08di4ryv9wyfb3ibh7s20ccijlfj35p";
      };
    };

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
      cargoSha256 = "1qbsx0lir161ybfvmmzq0pg96bmhkvkjwdlk2ji2f2gkrgc4h9bx";
    };
}
