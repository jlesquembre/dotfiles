{ config, pkgs, lib, ... }:
let
  hostName = "delta";
  h = import ../modules/helpers.nix { inherit pkgs; };

  nixos-hardware =
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixos-hardware/archive/0cb5491af9da8d6f16540ffc4db24e2361852e46.tar.gz";
      sha256 = "053d64zk6i8yx9mvz4q426wj00p9qlw2px6qghf0shqgsfg39b1l";
    });
in
{

  imports = [
    (import ../modules/common-configuration.nix {
      inherit hostName;
      enable-wifi = true;
      enable-bluetooth = true;
    })
    "${nixos-hardware}/dell/xps/13-9370"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
}