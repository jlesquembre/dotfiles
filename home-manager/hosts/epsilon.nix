{ config, pkgs, lib, secrets, ... }:
{
  home.file.rbi-gitconfig = {
    text = secrets.rbi.git-config;
    target = "RBI/.gitconfig";
  };
}
