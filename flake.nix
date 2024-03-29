{

  description = "Jose Luis Nix flake configuration";

  inputs = {
    # nixpkgs.url = "/home/jlle/nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      # url = "/home/jlle/home-manager";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    githud = {
      url = "github:gbataille/gitHUD";
    };

    # wired = {
    #   url = "github:Toqozz/wired-notify";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-medley = {
      # url = "/home/jlle/projects/nix-medley";
      url = "github:jlesquembre/nix-medley";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database =
      {
        url = "github:Mic92/nix-index-database";
        inputs.nixpkgs.follows = "nixpkgs";
      };

    flake-utils.url = "github:numtide/flake-utils";

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixos-hardware, flake-utils, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "jlle";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ (import ./overlays { }) ];
      };
      ageKeyFile = "/etc/nixos/key.txt";
      utils = (import ./lib { inherit pkgs; inherit ageKeyFile; });
      extraArgs =
        {
          rootPath = ./.;
          nix-medley = inputs.nix-medley.lib pkgs;
          inherit ageKeyFile;
        };

      hosts = {
        alfa = { };
        beta = {
          wifi = true;
          bluetooth = true;
          nixos-modules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
          ];
        };
      };

    in
    {
      homeConfigurations = utils.mkHomeConfig
        {
          inherit hosts system username pkgs inputs extraArgs;
          hmConfigDir = (builtins.toString ./home-manager);
        };

      nixosConfigurations = utils.mkHosts
        {
          inherit hosts system username pkgs inputs extraArgs;
          configDir = (builtins.toString ./nixos);
        };

    } //
    flake-utils.lib.eachSystem [ flake-utils.lib.system.x86_64-linux ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ (import ./overlays { }) ];
        };
        nix-medley = inputs.nix-medley.lib pkgs;
        utils = (import ./lib { inherit pkgs; });
      in
      rec{
        devShells =
          {
            default =
              pkgs.mkShell {
                packages = with pkgs;[
                  coreutils
                  curl
                  fish
                  git
                  imagemagick
                  nix
                  paperkey
                  pass
                  qrencode
                  sops
                  v4l-utils
                  zbar
                ];
              };
          };

        packages =
          let
            nvimConfig = import ./home-manager/neovim.nix {
              inherit pkgs nix-medley;
              rootPath = ./.;
              lib = pkgs.lib;
              config = null;
            };
          in
          {
            nvim-master =
              utils.mkNeovim (nvimConfig.programs.neovim // {
                nvimPackage = inputs.neovim.packages."${system}".neovim;
              });
            nvim =
              utils.mkNeovim nvimConfig.programs.neovim;
          };
        apps =
          {
            update-vim-plugins = {
              type = "app";
              program =
                let
                  vimDir = "./home-manager";
                  update-vim-plugins = pkgs.writeShellScriptBin "update-vim-plugins"
                    ''
                      ${builtins.toString nixpkgs}/pkgs/applications/editors/vim/plugins/update.py \
                        -i ${vimDir}/neovim-plugins.txt \
                        -o ${vimDir}/neovim-plugins-generated.nix --no-commit
                    '';
                in
                "${update-vim-plugins}/bin/update-vim-plugins";
            };
          };
      });
}
