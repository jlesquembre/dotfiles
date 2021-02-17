{ config, options, pkgs, lib, ... }:
{
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
  };

  services.blueman.enable = true;

  hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];
}
