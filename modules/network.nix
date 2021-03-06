{ hostName, userHome }:
{ config, options, pkgs, lib, ... }:
let
  docsPath = "${userHome}/projects/docs/public";
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

  networking.hostName = hostName;
  # networking.firewall.enable = false;
  networking.firewall.allowedTCPPorts = [ 8000 8080 ];

  # DNS configuration
  # networking.networkmanager.insertNameservers = [ "127.0.0.1" "::1" ];
  networking.resolvconf.useLocalResolver = true;
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
        {
          acme_ca https://127.0.0.1:8444/acme/acme/directory
          acme_ca_root ${root_ca_file}
          email no-reply@lafuente.com
        }

        docs.local {
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


  ## step-ca ACME server

  sops.secrets.step_password = {
    format = "yaml";
    sopsFile = ../sops/step_ca.yaml;
  };
  sops.secrets.step_intermediate_ca_key = {
    format = "yaml";
    sopsFile = ../sops/step_ca.yaml;
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
    settings = {
      dnsNames = [ "localhost" "127.0.0.1" "*.local" ];
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
