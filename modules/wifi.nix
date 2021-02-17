{ custom-networks }:
{ config, options, pkgs, lib, ... }:
{
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.wireless.userControlled.enable = true;
  networking.wireless.networks = custom-networks;

  environment.systemPackages = [
    pkgs.wpa_supplicant_gui
  ];
}
