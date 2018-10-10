{ config, pkgs, ... }:

{

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.blacklistedKernelModules = [ "nouveau" ];


  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.bumblebee.enable = true;
  hardware.enableAllFirmware = true;


  #services.xserver.videoDrivers = [ "nvidia" ];
  #services.xserver.videoDrivers = [ "nvidia" "vesa" ];
  services.xserver.synaptics.enable = true;

  #boot.blacklistedKernelModules = [ "i915" ];
  #boot.kernelParams = [ "nomodeset" "video=vesa:off" "vga=normal" ];
  #boot.vesa = false;

  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.userControlled.enable = true;
  networking.wireless.networks = import ../wireless-networks.nix {};
  environment.systemPackages = [
    # pkgs.cudatoolkit
    pkgs.wpa_supplicant_gui
  ];

  fileSystems."/mnt/yelster_public" = {
      device = "//192.168.70.2/public";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},guest,user=nobody,vers=1.0"];
  };

}
