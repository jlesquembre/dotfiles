{ pkgs, ageKeyFile ? "" }:
{

  mkNeovim =
    { withNodeJs
    , withPython3
    , withRuby
    , plugins
    , extraConfig
    , extraPackages ? [ ]
    , nvimPackage ? pkgs.neovim-unwrapped
    , ...
    }:
    let
      lib = pkgs.lib;
      extraMakeWrapperArgs = lib.optionalString (extraPackages != [ ])
        ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';

      nvimConf =
        pkgs.neovimUtils.makeNeovimConfig {
          configure.packages.home-manager.start = map (x: x.plugin or x) plugins;
          inherit withNodeJs withPython3 withRuby plugins;
          customRC = extraConfig;
        };
    in
    pkgs.wrapNeovimUnstable nvimPackage
      (nvimConf // {
        wrapperArgs = (lib.escapeShellArgs nvimConf.wrapperArgs) + " "
          + extraMakeWrapperArgs;
      });

  mkHomeConfig =
    { hosts, username, pkgs, inputs, hmConfigDir, extraArgs, system }:
    let
      inherit (pkgs.lib.attrsets) mapAttrs';

      mkHomeConfig' = { host, host-options }:
        let customCfg = hmConfigDir + "/hosts/${host}.nix"; in
        {
          name = "${username}@${host}";
          value = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              (/. + hmConfigDir + "/common.nix")
              {
                home = {
                  inherit username;
                  homeDirectory = "/home/${username}";
                };
                _module.args = extraArgs // {
                  inherit host-options inputs username system;
                };
              }
            ]
            ++ pkgs.lib.lists.optional (builtins.pathExists customCfg) (/. + customCfg);
          };
        };

    in
    mapAttrs'
      (name: value: mkHomeConfig' {
        host = name;
        host-options = value;
      })
      hosts;

  mkHosts =
    { hosts, username, pkgs, configDir, extraArgs, system, inputs }:
    let
      mkHost' = { host, host-options }:
        inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              _module.args = extraArgs // {
                inherit host-options inputs username;
                # NixOS already has a system option (a set).
                # Here system is one of systems defined in nixpkgs, it is a
                # string (e.g.: "x86_64-linux")
                nixpkgs-system = system;
              };
              networking.hostName = host;
              nixpkgs.pkgs = pkgs;
              environment.systemPackages = [
                inputs.home-manager.packages."${system}".home-manager
              ];
            }
            (/. + configDir + "/hosts/${host}.nix")
            (/. + configDir + "/common-configuration.nix")
            # (/. + configDir + "/cachix.nix")
            (/. + configDir + "/network.nix")
            inputs.sops-nix.nixosModules.sops
          ] ++ host-options.nixos-modules or [ ]

          ++ pkgs.lib.lists.optional (host-options.bluetooth or false)
            (/. + configDir + "/bluetooth.nix")

          ++ pkgs.lib.lists.optional (host-options.wifi or false)
            (/. + configDir + "/wifi.nix")
          ;
        };
    in
    builtins.mapAttrs
      (name: value: mkHost' {
        host = name;
        host-options = value;
      })
      hosts;
}
