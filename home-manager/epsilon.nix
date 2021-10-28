{ config, pkgs, lib, ... }:

let
  h = import ../modules/helpers.nix { inherit pkgs; };
  secrets = h.import-secret ../sops/secrets.nix;
in
{
  imports = [ ./common.nix ];
  services.blueman-applet.enable = true;
  home.file.rbi-gitconfig = {
    text = secrets.rbi.git-config;
    target = "RBI/.gitconfig";
  };
}
