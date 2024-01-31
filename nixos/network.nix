{ config, options, pkgs, lib, username, ... }:
let
  docsPath = "/home/${username}/projects/docs";
  root_ca =
    ''
      -----BEGIN CERTIFICATE-----
      MIIBoTCCAUagAwIBAgIRAKsPgQid31Ab2S8cCNVfdw4wCgYIKoZIzj0EAwIwLjER
      MA8GA1UEChMITGFmdWVudGUxGTAXBgNVBAMTEExhZnVlbnRlIFJvb3QgQ0EwHhcN
      MjEwNDE0MTUxMTE1WhcNMzEwNDEyMTUxMTE1WjAuMREwDwYDVQQKEwhMYWZ1ZW50
      ZTEZMBcGA1UEAxMQTGFmdWVudGUgUm9vdCBDQTBZMBMGByqGSM49AgEGCCqGSM49
      AwEHA0IABBdSYgRwuaUdBw3ib3iTmqJYGeqRghOV658ws56ooNyr977yHypHfMJx
      laE3UKQ8edPU3om+qBIkgNgRD7VHPy+jRTBDMA4GA1UdDwEB/wQEAwIBBjASBgNV
      HRMBAf8ECDAGAQH/AgEBMB0GA1UdDgQWBBRR+escFXYwDgSdbxLoCVCc8zznTDAK
      BggqhkjOPQQDAgNJADBGAiEA+w6OMfyQiXL3Cp5brH5aUi+P3by/8LALxXy110TZ
      IgYCIQDV5e9LhRrbe5yqUWSXpA+CG9oLXY9gPEvOprBR9vdE4w==
      -----END CERTIFICATE-----
    '';
  intermediate_ca =
    ''
      -----BEGIN CERTIFICATE-----
      MIIByjCCAW+gAwIBAgIRAPXKzOVAgCH693AezoJRn3swCgYIKoZIzj0EAwIwLjER
      MA8GA1UEChMITGFmdWVudGUxGTAXBgNVBAMTEExhZnVlbnRlIFJvb3QgQ0EwHhcN
      MjEwNDE0MTUxMTE1WhcNMzEwNDEyMTUxMTE1WjA2MREwDwYDVQQKEwhMYWZ1ZW50
      ZTEhMB8GA1UEAxMYTGFmdWVudGUgSW50ZXJtZWRpYXRlIENBMFkwEwYHKoZIzj0C
      AQYIKoZIzj0DAQcDQgAEBwaZZN+ow7bC2WA7O/u6KRB0qFYN/VAsCGr43VsWd7ox
      ehzn0GevECNnPGKWivuDLNFCBzncZIQtr970o+nf8qNmMGQwDgYDVR0PAQH/BAQD
      AgEGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFC3KI7cCMfqXjR403h86
      AzUucPYRMB8GA1UdIwQYMBaAFFH56xwVdjAOBJ1vEugJUJzzPOdMMAoGCCqGSM49
      BAMCA0kAMEYCIQCcUjWEa94OY5UNohOuLMmPAA3Ve/J8f6v1Y1Y4n4U6wAIhAOzh
      PD01G/SmkfdW0qSxxN9TFXgnWxlZawLTlwYJqrAZ
      -----END CERTIFICATE-----
    '';
  root_ca_file = pkgs.writeTextFile {
    name = "root.ca";
    text = root_ca;
  };

in
{

  # networking.firewall.enable = false;
  networking.firewall.allowedTCPPorts = [ 8000 8080 ];

  systemd.network = {
    enable = true;

    # The notion of "online" is a broken concept
    wait-online.enable = false;

    # man systemd.network
    # networks."wlan" =
    #   {
    #     matchConfig = { Name = "wl*"; };
    #     networkConfig = { DHCP = "ipv4"; };
    #     dhcpV4Config = { UseDNS = false; };
    #   };

    # networks."eth" =
    #   {
    #     matchConfig = { Name = "en*"; };
    #     networkConfig = { DHCP = "ipv4"; };
    #     dhcpV4Config = { UseDNS = false; };
    #   };

    # Bonding
    # https://wiki.archlinux.org/title/systemd-networkd#Bonding_a_wired_and_wireless_interface
    netdevs."30-bond0" = {
      netdevConfig = {
        Name = "bond0";
        Kind = "bond";
      };
      bondConfig = {
        Mode = "active-backup";
        PrimaryReselectPolicy = "always";
        MIIMonitorSec = "1s";
      };
    };

    networks."30-eth-bond0" = {
      matchConfig = { Name = "en*"; };
      networkConfig = {
        Bond = "bond0";
        PrimarySlave = true;
      };
    };
    networks."30-wifi-bond0" = {
      matchConfig = { Name = "wl*"; };
      networkConfig = { Bond = "bond0"; };
    };

    networks."30-bond0" = {
      matchConfig = { Name = "bond0"; };
      networkConfig = { DHCP = "ipv4"; };
      dhcpV4Config = { UseDNS = false; };
    };

    # # Bridge
    # netdevs."00-br0" =
    #   {
    #     netdevConfig = { Name = "virbr0"; Kind = "bridge"; };
    #   };
    # networks."00-br0" = {
    #   matchConfig = { Name = "virbr0"; };
    #   networkConfig = {
    #     Address = "172.55.0.1/24";
    #     ConfigureWithoutCarrier = true;
    #     IPForward = true;
    #     IPMasquerade = true;
    #   };
    # };
  };

  networking.nameservers = [ "127.0.0.1" "::1" ]; # used by services.resolved.DNS
  services.resolved = {
    enable = true;
    domains = [ "local" ];
    llmnr = "false";
    extraConfig = ''
      DNSStubListener=no
    '';
  };

  networking.dhcpcd.enable = false;
  networking.useNetworkd = lib.mkDefault true;
  networking.useDHCP = lib.mkDefault false;


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
      (default) {
        # log
        # errors
        # Cloudflare, Google and OpenDNS
        forward . ${ips}
      }

      . {
        import default
        cache
      }

      # local {
      #   template IN A  {
      #       answer "{{ .Name }} 0 IN A 127.0.0.1"
      #   }
      # }

      kube {
        template IN A  {
            answer "{{ .Name }} 0 IN A 192.168.49.2"
        }
      }

      home.arpa {
        # log
        # errors
        template IN A  {
            answer "{{ .Name }} 0 IN A 127.0.0.1"
        }
      }
    '';

  services.caddy = {
    enable = true;
    acmeCA = null;
    globalConfig =
      ''
        acme_ca https://127.0.0.1:8444/acme/acme/directory
        acme_ca_root ${root_ca_file}
        email no-reply@lafuente.com
        on_demand_tls {
          ask      http://check.home.arpa/check
          interval 1s
          burst 10
        }
        # log {
        #   level DEBUG
        # }
      '';
    extraConfig =
      ''
        check.home.arpa:80 {
          @check {
            path /check
            expression {query.domain}.endsWith(".home.arpa") || {query.domain}.endsWith(".local")
          }

          route {
            respond @check 200
            respond * 400
          }
        }

        (local_cert) {
          tls {
              on_demand
              ca https://127.0.0.1:8444/acme/acme/directory
              ca_root ${root_ca_file}
          }
        }

        docs.home.arpa {
          import local_cert
          bind 127.0.0.1
          root * ${docsPath}/public
          file_server
          header {
            -Last-Modified
            -Etag
            cache-control no-store
          }
        }
      '';
  };

  # Needed to make the directory visible to Caddy
  systemd.services.caddy.serviceConfig = {
    ProtectHome = lib.mkForce "tmpfs";
    BindReadOnlyPaths = "${docsPath}";
  };


  ## step-ca ACME server

  sops.secrets.step_password = { };
  sops.secrets.step_intermediate_ca_key = {
    mode = "0440";
    group = config.users.groups.keys.name;
  };

  security.pki.certificates = [
    root_ca
    intermediate_ca
  ];

  services.step-ca = {
    enable = true;
    address = "127.0.0.1";
    port = 8444;
    intermediatePasswordFile = config.sops.secrets.step_password.path;
    # See
    # https://smallstep.com/docs/step-ca/configuration#basic-configuration-options
    settings = {
      dnsNames = [ "localhost" "127.0.0.1" "*.home.arpa" "*.local" ];
      root = root_ca_file;
      crt = pkgs.writeTextFile {
        name = "intermediate.ca";
        text = intermediate_ca;
      };
      key = config.sops.secrets.step_intermediate_ca_key.path;
      db = {
        type = "badger";
        dataSource = "/var/lib/step-ca/db";
      };
      authority = {
        claims = {
          minTLSCertDuration = "5m";
          maxTLSCertDuration = "24h";
          defaultTLSCertDuration = "24h";
        };
        provisioners = [
          {
            type = "ACME";
            name = "acme";
            forceCN = true;
          }
        ];
      };
    };
  };

  systemd.services.step-ca.serviceConfig = {
    SupplementaryGroups = [ config.users.groups.keys.name ];
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
