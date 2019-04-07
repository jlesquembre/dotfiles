{ config, pkgs, ... }:

{

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable touchpad, for options
  # see https://nixos.org/nixos/options.html#libinput
  services.xserver.libinput.enable = true;

  hardware.cpu.intel.updateMicrocode = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.enableAllFirmware = true;

  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.userControlled.enable = true;
  networking.wireless.networks = import ../wireless-networks.nix {};
  environment.systemPackages = [
    pkgs.wpa_supplicant_gui
    pkgs.blueman
  ];

  hardware.bluetooth = {
    enable = true;
  };

  hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];

}
