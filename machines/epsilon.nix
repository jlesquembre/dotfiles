{ config, pkgs, lib, ... }:
let
  hostName = "epsilon";
  h = import ../modules/helpers.nix { inherit pkgs; };

  nixos-hardware =
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixos-hardware/archive/7da029f26849f8696ac49652312c9171bf9eb170.tar.gz";
      sha256 = "0xhhm1gk28fhzqsd260kr007vpir10xvp5cq0sdy1fnzzp8wcyf5";
    });
in
{

  imports = [
    (import ../modules/common-configuration.nix {
      inherit hostName;
      enable-wifi = true;
      enable-bluetooth = true;
    })
    "${nixos-hardware}/lenovo/thinkpad/p53"
  ];

  # networking.wireless.interfaces = [ "wlp2s0" ];
  networking.wireless.interfaces = [ "wlp82s0" ];

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
