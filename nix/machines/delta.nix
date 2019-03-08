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
    pkgs.blueman
  ];

  fileSystems."/mnt/yelster_public" = {
      device = "//192.168.70.2/public";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},guest,user=nobody,vers=1.0"];
  };

  hardware.bluetooth = {
    enable = true;
    # extraConfig = "
    #   [General]
    #   Enable=Source,Sink,Media,Socket
    # ";
  };

  hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];
  # hardware.pulseaudio.configFile = pkgs.writeText "default.pa" ''
  #   load-module module-bluetooth-policy
  #   load-module module-bluetooth-discover
  #   ## module fails to load with
  #   ##   module-bluez5-device.c: Failed to get device path from module arguments
  #   ##   module.c: Failed to load module "module-bluez5-device" (argument: ""): initialization failed.
  #   # load-module module-bluez5-device
  #   # load-module module-bluez5-discover
# '';

}
