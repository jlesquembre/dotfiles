{ config, options, pkgs, lib, import-secret, ... }:
let
  custom-networks = import-secret ../sops/wireless-networks.nix;
in
{
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.wireless.userControlled.enable = true;
  networking.wireless.networks = {

    HUAWEI-B525-5G-F6BF = {
      psk = "@HUAWEI_B525_psk@";
    };

    NETGEAR71-5G = {
      psk = "@NETGEAR71_psk@";
    };

    "@work1_uuid@" = {
      psk = "@work1_psk@";
    };

    "@home1_uuid@" = {
      psk = "@home_psk@";
    };

    "@home2_uuid@" = {
      psk = "@home_psk@";
    };

    "@work2_uuid@" = {
      auth = ''
        key_mgmt=WPA-EAP
        eap=PEAP
        phase2="auth=MSCHAPV2"
        identity="@work2_id@"
        password="@work2_pass@"
      '';
    };

  };

  sops.secrets."wireless.env" = { };
  networking.wireless.environmentFile = config.sops.secrets."wireless.env".path;

  environment.systemPackages = [
    pkgs.wpa_supplicant_gui
  ];
}
