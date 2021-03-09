{ secrets, user, userHome }:
{ config, options, pkgs, lib, ... }:
{
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      secrets.g-systems.zerotier-network
    ];
  };


  security.pki.certificates = [
    secrets.g-systems.ca-cert
  ];

  services.coredns.config = lib.mkAfter secrets.g-systems.coredns-config;

  services.openvpn.servers = secrets.g-systems.openvpn-config;

  sops.secrets.ovpn_credentials_1 = {
    format = "yaml";
    sopsFile = ../sops/openvpn.yaml;
  };
  sops.secrets.ovpn_config_1 = {
    format = "yaml";
    sopsFile = ../sops/openvpn.yaml;
  };
}
