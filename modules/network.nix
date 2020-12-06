{ hostName, userHome }:
{ config, options, pkgs, lib, ... }:
let
  docsPath = "${userHome}/projects/docs/public";
in
{

  networking.hostName = hostName;
  # networking.firewall.enable = false;
  networking.firewall.allowedTCPPorts = [ 8000 8080 ];

  # DNS configuration
  networking.networkmanager.insertNameservers = [ "127.0.0.1" ];
  # Don't use dns server provided by dhcp server
  networking.dhcpcd.extraConfig =
    ''
      nohook resolv.conf
    '';

  services.coredns.enable = true;
  services.coredns.config =
    let
      ips = lib.strings.concatStringsSep " "
        [
          # Cloudflare
          "1.1.1.1"
          "1.0.0.1"
          # Google
          "8.8.8.8"
          "8.8.4.4"
          #OpenDNS
          "208.67.222.222"
          "208.67.220.220"
        ];
    in
    ''
      . {
        # log
        # errors
        # Cloudflare, Google and OpenDNS
        forward . ${ips}
        cache
      }

      local {
        # log
        # errors
        template IN A  {
            answer "{{ .Name }} 0 IN A 127.0.0.1"
        }
      }
    '';

  services.caddy = {
    enable = true;
    config =
      ''
        http://docs.local {
          bind 127.0.0.1
          root * ${docsPath}
          file_server
          header {
            -Last-Modified
            -Etag
            Cache-Control "no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0"
          }
        }
      '';

  };

  # Needed to make the directory visible to Caddy
  systemd.services.caddy.serviceConfig = {
    ProtectHome = lib.mkForce "tmpfs";
    BindReadOnlyPaths = "${docsPath}";
  };

  # Old dnsmasq config, replaced by CoreDNS

  # services.dnsmasq.enable = true;
  # # For dnscrypt use:
  # services.dnsmasq.servers = [ "127.0.0.1#43" ];
  # services.dnsmasq.servers = [
  #   # Cloudflare
  #   "1.1.1.1"
  #   "1.0.0.1"

  #   # OpenDNS
  #   "208.67.222.222"
  #   "208.67.220.220"

  #   # Google
  #   "8.8.8.8"
  #   "8.8.4.4"
  # ];
  # services.dnsmasq.extraConfig =
  #   ''
  #     address=/.local/127.0.0.1
  #   '';
}
