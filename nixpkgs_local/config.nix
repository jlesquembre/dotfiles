# Put it on ~/.nixpkgs/config.nix
# https://nixos.org/wiki/Crash_Course#Writing_your_own_nix_packages
{
   packageOverrides = pkgs : with pkgs; rec {

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

    /*
    Creates a collection package, now we can be install/update local packages by running:
    nix-env -iA nixpkgs.all  # accessed by attribute thus faster
    nix-env -i all
    */
    all = with pkgs; buildEnv {  # pkgs is your overriden set of packages itself
      name = "all";
      paths = [
        # hello_jl
        #httpstat
        #httplab
        #wuzz
        conky
      ];
    };

     # A derivation of a build environment that you may later 'source' in your bash
     # to build programs linked with alsa.
     #alsaEnv = pkgs.myEnvFun {
       #    name = "alsa";
       #         buildInputs = [ stdenv alsaLib ];
         #};
   };
}
