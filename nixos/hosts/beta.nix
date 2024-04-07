{ config, pkgs, lib, ... }:
{

  networking.wireless.interfaces = [ "wlp0s20f3" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # Enable touchpad, for options
  # see https://nixos.org/nixos/options.html#libinput
  services.xserver.libinput.enable = true;

  # https://github.com/NixOS/nixpkgs/pull/62101
  services.throttled.enable = true;

  # hardware.cpu.intel.updateMicrocode = true;

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
  hardware.cpu.intel.updateMicrocode = true;

  environment.systemPackages = [ pkgs.vulkan-validation-layers ];
  boot.kernelModules = [
    # "kvm-amd"
    "kvm-intel"
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # ====
  # ====
  # Generated by ‘nixos-generate-config’
  # ====
  # ====

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/c4f4bec6-ce18-4ef2-b0d3-8bb353e3030d";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/D377-C411";
      fsType = "vfat";
    };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  # high-resolution display

  # OLD hardware.video.hidpi.enable settings
  # console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";

  # # Needed when typing in passwords for full disk encryption
  # console.earlySetup = lib.mkDefault true;
  # boot.loader.systemd-boot.consoleMode = lib.mkDefault "1";

  # # Grayscale anti-aliasing for fonts
  # fonts.fontconfig.antialias = lib.mkDefault true;
  # fonts.fontconfig.subpixel = {
  #   rgba = lib.mkDefault "none";
  #   lcdfilter = lib.mkDefault "none";
  # };
}
