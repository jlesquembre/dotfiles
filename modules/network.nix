{ hostName, userHome }:
{ config, options, pkgs, lib, ... }:
let
  caddyDir = "/var/lib/caddy";
  caddyConfig = pkgs.writeText "Caddyfile"
    ''
      {
        storage file_system {
          root ${caddyDir}
        }
      }

      http://docs.local {
        bind 127.0.0.1
        root * ${userHome}/projects/docs/public
        file_server
        header {
          -Last-Modified
          -Etag
          Cache-Control "no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0"
        }
      }
    '';
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


  # https://github.com/caddyserver/dist/blob/master/init/caddy.service
  systemd.services.caddy = {
    description = "Caddy web server";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "caddy";
      Group = "caddy";
      ExecStart = ''
        ${pkgs.caddy2}/bin/caddy run --config ${caddyConfig} --adapter caddyfile
      '';
      ExecReload = ''
        ${pkgs.caddy2}/bin/caddy reload --config ${caddyConfig} --adapter caddyfile
      '';
      TimeoutStopSec = "5s";
      LimitNOFILE = 1048576;
      LimitNPROC = 512;
      PrivateTmp = true;
      ProtectSystem = "full";
      AmbientCapabilities = "cap_net_bind_service";
    };
  };

  users.users.caddy = {
    group = "caddy";
    uid = config.ids.uids.caddy;
    home = caddyDir;
    createHome = true;
    extraGroups = [ "users" ];
  };

  users.groups.caddy.gid = config.ids.uids.caddy;


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
