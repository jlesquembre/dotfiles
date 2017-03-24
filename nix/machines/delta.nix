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
  networking.wireless.networks = import ../wireless-networks.nix {};

}
