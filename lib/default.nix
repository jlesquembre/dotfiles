{ pkgs, ageKeyFile }:
{
  import-secret = secretPath: (builtins.exec [
    "sh"
    "-c"
    ''SOPS_AGE_KEY_FILE=${ageKeyFile} ${pkgs.sops}/bin/sops -d ${secretPath}''
  ]);

  mkHomeConfig =
    { hosts, username, pkgs, inputs, hmConfigDir, extraArgs, system }:
    let
      inherit (pkgs.lib.attrsets) mapAttrs';

      mkHomeConfig' = { host, host-options }:
        let customCfg = hmConfigDir + "/hosts/${host}.nix"; in
        {
          name = "${username}@${host}";
          value = inputs.home-manager.lib.homeManagerConfiguration {
            inherit system username pkgs;
            homeDirectory = "/home/${username}";
            extraSpecialArgs = extraArgs // { inherit host-options inputs system; };
            configuration.imports = [ (/. + hmConfigDir + "/common.nix") ]
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
              _module.args = extraArgs // { inherit host-options inputs username system; };
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
