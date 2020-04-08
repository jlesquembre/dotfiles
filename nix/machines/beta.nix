{ config, pkgs, ... }:

{

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "i915" ];

  # https://github.com/NixOS/nixos-hardware/blob/master/common/cpu/intel/kaby-lake/default.nix
  # boot.kernelParams = [
  #   "i915.enable_fbc=1"
  #   "i915.enable_psr=2"
  #   # "i915.enable_guc=2"
  # ];

  # https://github.com/NixOS/nixos-hardware/blob/master/common/pc/laptop/acpi_call.nix
  boot.kernelModules = [ "acpi_call" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

  # Enable touchpad, for options
  # see https://nixos.org/nixos/options.html#libinput
  services.xserver.libinput.enable = true;

  # https://github.com/NixOS/nixpkgs/pull/62101
  services.throttled.enable = true;

  hardware.cpu.intel.updateMicrocode = true;

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
  };


  hardware.enableAllFirmware = true;

  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.wireless.userControlled.enable = true;
  networking.wireless.networks = import ../wireless-networks.nix {};
  environment.systemPackages = [
    pkgs.wpa_supplicant_gui
    # pkgs.blueman
  ];


  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
  };

  services.blueman.enable = true;

  hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];

}
