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

    nix-medley = {
      # url = "/home/jlle/projects/nix-medley";
      url = "github:jlesquembre/nix-medley";
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
          import-secret = utils.import-secret;
          secrets = utils.import-secret ./sops/secrets.nix;
          nix-medley = inputs.nix-medley.lib pkgs;
          inherit ageKeyFile;
        };

      hosts = {
        alfa = { };
        epsilon = {
          wifi = true;
          bluetooth = true;
          nixos-modules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-p53
            ./nixos/rbi.nix
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
    flake-utils.lib.eachDefaultSystem (system:
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
        devShell =
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
              zbar
            ];
          };

        packages = {
          nvim =
            let
              nvimConfig = import ./home-manager/neovim.nix {
                inherit pkgs nix-medley;
                lib = pkgs.lib;
                config = null;
              };
            in
            utils.mkNeovim (nvimConfig.programs.neovim // {
              # Neovim master
              nvimPackage = inputs.neovim.packages."${system}".neovim;
            });
        };
        apps =
          {
            nvim = flake-utils.lib.mkApp { drv = packages.nvim; name = "nvim"; };

            update-vim-plugins =
              {
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
