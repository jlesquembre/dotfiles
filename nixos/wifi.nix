{ config, options, pkgs, lib, ... }:
{
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.wireless.userControlled.enable = true;

  sops.secrets."wireless.env" = { };
  networking.wireless.environmentFile = config.sops.secrets."wireless.env".path;

  environment.systemPackages = [
    pkgs.wpa_supplicant_gui
  ];

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

    PBS-2EF4E9 = {
      psk = "@PBS_psk@";
    };

    PBS-2EF4E9_EXT = {
      psk = "@PBS_psk@";
    };

    s5_5 = {
      psk = "@s5_psk@";
    };

    "@cowork_uuid@" = {
      psk = "@cowork_psk@";
    };

    TP-Link_1458_5G = {
      psk = "@TPLINK_psk@";
    };
    TP-Link_1459 = {
      psk = "@TPLINK_psk@";
    };

    "@home3_uuid@" = {
      psk = "@home3_psk@";
    };

    "@work3_uuid@" = {
      auth = ''
        key_mgmt=WPA-EAP
        eap=PEAP
        identity="@work3_id@"
        password="@work3_pass@"
      '';
    };

    ONB-WLAN-PUBLIKUM = { };
    WESTlan = { };
    AK-Wien = { };
    "Citadines Bastille " = { };
    WOJO-GUEST = { };
  };
}
