{ secrets, user, userHome }:
{ config, options, pkgs, lib, ... }:
let
  connect-ewp-gateway = (secrets.rbi.connect-ewp-gateway pkgs);
in
{
  services.coredns.config = lib.mkAfter (secrets.rbi.coredns-config lib);
  environment.systemPackages = with pkgs; [
    yubioath-desktop
    (pkgs.writeShellScriptBin "connect-ewp-gateway" "sudo ${connect-ewp-gateway}/bin/connect-ewp-gateway $1")
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
