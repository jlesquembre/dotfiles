{

  description = "Jose Luis Nix flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "/home/jlle/nixpkgs";

    # add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = github:Mic92/sops-nix;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hw-config.url = "/etc/nixos/hardware-configuration.nix";
    # hw-config.flake = false;

    # hw-config.url = "/etc/nixos";
    # hw-config.flake = false;
  };
  # inputs.nixpkgs.url = "path:/home/jlle/nixpkgs";

  outputs = { self, nixpkgs, nixos-hardware, sops-nix, home-manager }: {

    nixosConfigurations = {
      epsilon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [
            ./nixos/hosts/epsilon.nix
            # /etc/nixos/hardware-configuration.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-p53
            sops-nix.nixosModules.sops
            # ({ pkgs, ... }: {
            #   boot.isContainer = true;

            #   # Let 'nixos-version --json' know about the Git revision
            #   # of this flake.
            #   system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;

            #   # Network configuration.
            #   networking.useDHCP = false;
            #   networking.firewall.allowedTCPPorts = [ 80 ];

            #   # Enable a web server.
            #   services.httpd = {
            #     enable = true;
            #     adminAddr = "morty@example.org";
            #   };
            # })
          ];
      };
    };

  };
}

## TODO

# Move /machines to /nixos/hosts
# Move /etc/nixos/hardware-configuration.nix to $HOSTNAME.nix
# Rename /modules to /nixos
# Remove all fetchFromTarball
# Transform helpers.nix / nix-medley into a flake
# Remove /overlays
# home-manager
# nix-sops

## Examples:
# https://github.com/tadfisher/flake
# https://github.com/wiltaylor/dotfiles
