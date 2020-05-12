# Put it on ~/.nixpkgs/config.nix
# https://nixos.org/wiki/Crash_Course#Writing_your_own_nix_packages
{


  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; rec {

    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };

    # If you want to debug linphone and its alsa libraries, let's keep the symbols and use -O0 for them:
    #alsaLibDebug = pkgs.misc.debugVersion pkgs.alsaLib;
    #linphoneDebug = pkgs.misc.debugVersion (pkgs.linphone.override {
    #  alsaLib = alsaLibDebug;
    #});


    # Another program, this time with maybe a more complex expression
    # that you prefer to keep in a file apart.
    # hello_jl = callPackage ./pkgs/hello {};

    conky = pkgs.conky.override {
      lua = pkgs.lua5_3;
      luaImlib2Support = false;
      luaCairoSupport = false;
    };

    customOkular = pkgs.writeScriptBin "okular" ''
      #!/usr/bin/env bash
      export XDG_CURRENT_DESKTOP=KDE
      exec ${pkgs.okular}/bin/okular "$@"
    '';


    #customHaskellEnv = pkgs.haskell.packages.ghc802.ghcWithPackages
    customHaskellEnv = pkgs.haskellPackages.ghcWithPackages
      (
        haskellPackages: with haskellPackages; [
          # libraries
          parsec
          QuickCheck
          # tools
          #cabal-install haskintex
        ]
      );
    nodeEnv = buildEnv {
      name = "nodeEnv";
      paths = [ nodejs-8_x ] ++ (
        with nodePackages; [
          #babel
          replem
          npm2nix
          coffee-script
          #jsonlint
        ]
      );
    };

    /*
    Creates a collection package, now we can be install/update local packages by running:
    nix-env -irA nixpkgs.all  # accessed by attribute thus faster
    nix-env -ir all
    */

    # pkgs is your overriden set of packages itself
    all = with pkgs; buildEnv {
      name = "all";
      paths = [
        # hello_jl
        # customHaskellEnv
        # conky
        # customOkular
        nix-index
        nur.repos.mic92.nix-update
      ];
    };

    # A derivation of a build environment that you may later 'source' in your bash
    # to build programs linked with alsa.
    #alsaEnv = pkgs.myEnvFun {
    #  name = "alsa";
    #  buildInputs = [ stdenv alsaLib ];
    #};
  };
}
