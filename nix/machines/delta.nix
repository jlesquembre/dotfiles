
{ config, pkgs, ... }:

{

  hardware.opengl.driSupport32Bit = true;
  hardware.bumblebee.enable = true;
  #services.xserver.videoDrivers = [ "nvidia" ];


  boot.blacklistedKernelModules = [ "nouveau" ];
  #boot.blacklistedKernelModules = [ "i915" ];
  #boot.kernelParams = [ "nomodeset" "video=vesa:off" "vga=normal" ];
  #boot.vesa = false;

  hardware.opengl.enable = true;
  #hardware.opengl.driSupport32Bit = true;
  #services.xserver.videoDrivers = [ "nvidia" "vesa" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
