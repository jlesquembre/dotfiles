{ secrets, user, userHome }:
{ config, options, pkgs, lib, ... }:
{
  services.zerotierone = {
    enable = true;
    joinNetworks = secrets.zerotier-networks;
  };


  sops.secrets.zerotiertoken = {
    owner = user;
    path = "${userHome}/.zeroTierOneAuthToken";
    format = "binary";
    sopsFile = ../sops/gsystems/zerotiertoken.txt;
  };

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
