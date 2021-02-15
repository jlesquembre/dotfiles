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

  services.coredns.config = lib.mkAfter
    ''
      noenv.aws {
        template IN A  {
            answer "{{ .Name }} 0 IN A 10.100.11.114"
        }
      }

      noenv.io {
        template IN A  {
            answer "{{ .Name }} 0 IN A 10.100.11.114"
        }
      }
    '';

}
