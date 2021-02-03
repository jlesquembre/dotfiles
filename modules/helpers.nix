{ pkgs }:
{
  import-secret = secretPath: (builtins.exec [
    "${pkgs.sops}/bin/sops"
    "-d"
    secretPath
  ]);
}
