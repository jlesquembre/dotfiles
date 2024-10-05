{ config, options, pkgs, lib, ... }:
{
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.wireless.userControlled.enable = true;

  sops.secrets."wireless.conf" = { };
  networking.wireless.secretsFile = config.sops.secrets."wireless.conf".path;

  environment.systemPackages = [
    pkgs.wpa_supplicant_gui
  ];

  networking.wireless.networks = {

    HUAWEI-B525-5G-F6BF = {
      pskRaw = "ext:HUAWEI_B525_psk";
    };

    NETGEAR71-5G = {
      pskRaw = "ext:NETGEAR71_psk";
    };

    noenv = {
      pskRaw = "ext:noenv_psk";
    };

    JLNet = {
      pskRaw = "ext:home_psk";
    };

    ZTE_FE071B_5G = {
      pskRaw = "ext:home_psk";
    };

    DIGIFIBRA-PLUS-TFtH = {
      pskRaw = "ext:alicante_psk";
    };

    DIGIFIBRA-TFtH_TPlink-Ext = {
      pskRaw = "ext:alicante_psk";
    };

    PBS-2EF4E9 = {
      pskRaw = "ext:PBS_psk";
    };

    PBS-2EF4E9_EXT = {
      pskRaw = "ext:PBS_psk";
    };

    s5_5 = {
      pskRaw = "ext:s5_psk";
    };

    coworking-seesternaspern-5ghz = {
      pskRaw = "ext:cowork_psk";
    };

    TP-Link_1458_5G = {
      pskRaw = "ext:TPLINK_psk";
    };
    TP-Link_1459 = {
      pskRaw = "ext:TPLINK_psk";
    };


    ONB-WLAN-PUBLIKUM = { };
    WESTlan = { };
    AK-Wien = { };
    WKWGAST = { };
    "Citadines Bastille " = { };
    WOJO-GUEST = { };
    REGUS = { };
  };
}
