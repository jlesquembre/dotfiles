{ config, pkgs, lib, ... }:
{
  imports = [ ./common.nix ];
  services.blueman-applet.enable = true;
}
