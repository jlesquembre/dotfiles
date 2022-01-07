{

  description = "Jose Luis Nix flake configuration";

  inputs = {
    nixpkgs.url = "/home/jlle/nixpkgs";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
      url = "github:jlesquembre/gitHUD";
    };

    nix-medley = {
      url = "/home/jlle/projects/nix-medley";
      # url = github:jlesquembre/nix-medley;
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixos-hardware, sops-nix, nix-medley, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "jlle";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        # TODO move overlays to nix-medley
        overlays = [ (import ./overlays/common/default.nix { }) ];
      };
      ageKeyFile = "/etc/nixos/key.txt";
      utils = (import ./lib { inherit pkgs; inherit ageKeyFile; });
      extraArgs =
        {
          import-secret = utils.import-secret;
          secrets = utils.import-secret ./sops/secrets.nix;
          nix-medley = nix-medley.lib pkgs;
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
    };
}

## TODO

# Transform helpers.nix / nix-medley into a flake
# Remove /overlays
# move shell.nix to flake
# extra neovim to its own flake?

## Examples:
# https://github.com/tadfisher/flake
# https://github.com/wiltaylor/dotfiles
