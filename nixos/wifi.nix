{ config, options, pkgs, lib, import-secret, ... }:
let
  custom-networks = import-secret ../sops/wireless-networks.nix;
in
{
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.wireless.userControlled.enable = true;
  networking.wireless.networks = custom-networks;

  environment.systemPackages = [
    pkgs.wpa_supplicant_gui
  ];
}
