{ secrets, user, userHome }:
{ config, options, pkgs, lib, ... }:
{
  services.coredns.config = lib.mkAfter (secrets.rbi.coredns-config lib);
  environment.systemPackages = with pkgs; [
    yubioath-desktop
    (secrets.rbi.connect-ewp-gateway pkgs)
  ];

  services.pcscd.enable = true;

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    abrmd.enable = true;
    tctiEnvironment = {
      enable = true;
      interface = "tabrmd";
    };
  };
}
