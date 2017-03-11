# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let hostName = "${lib.fileContents ./hostname}";
in
rec
{


  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      # Import machine-specific configuration files.
      (./machines + "/${hostName}.nix")
    ];

#  # Use the GRUB 2 boot loader.
#  boot.loader.grub.enable = true;
#  boot.loader.grub.version = 2;
#  # boot.loader.grub.efiSupport = true;
#  # boot.loader.grub.efiInstallAsRemovable = true;
#  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
#  # Define on which hard drive you want to install Grub.
#  boot.loader.grub.device = "/dev/sdc"; # or "nodev" for efi only
#  boot.loader.grub.extraEntries = ''
#menuentry 'Arch Linux' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-simple-ed50fb2d-5e65-4ced-8229-fa83dffc8e8e' {
#  if [ x$feature_all_video_module = xy ]; then
#    insmod all_video
#  else
#    insmod efi_gop
#    insmod efi_uga
#    insmod ieee1275_fb
#    insmod vbe
#    insmod vga
#    insmod video_bochs
#    insmod video_cirrus
#  fi
#	set gfxpayload=keep
#	insmod gzio
#	insmod part_msdos
#	insmod ext2
#	set root='hd1,msdos1'
#	if [ x$feature_platform_search_hint = xy ]; then
#	  search --no-floppy --fs-uuid --set=root --hint-bios=hd1,msdos1 --hint-efi=hd1,msdos1 --hint-baremetal=ahci1,msdos1  f328d967-9f2a-46e1-9179-05fa334f69b3
#	else
#	  search --no-floppy --fs-uuid --set=root f328d967-9f2a-46e1-9179-05fa334f69b3
#	fi
#	echo	'Loading Linux linux ...'
#	linux	/vmlinuz-linux root=UUID=ed50fb2d-5e65-4ced-8229-fa83dffc8e8e rw  quiet
#	echo	'Loading initial ramdisk ...'
#	initrd	/intel-ucode.img /initramfs-linux.img
#}
#
#menuentry 'Windows 7 (loader) (on /dev/sda1)' --class windows --class os $menuentry_id_option 'osprober-chain-C848FF1848FF03CA' {
#	insmod part_msdos
#	insmod ntfs
#	set root='hd0,msdos1'
#	if [ x$feature_platform_search_hint = xy ]; then
#	  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci0,msdos1  C848FF1848FF03CA
#	else
#	  search --no-floppy --fs-uuid --set=root C848FF1848FF03CA
#	fi
#	chainloader +1
#}
#
#'';

  networking.hostName = "${hostName}";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
  #   consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    neovim
    gitAndTools.gitFull
    tig
    ranger
    termite
    chromium
    fish
    atool
    file
    keychain
    rsync
    autojump
    vlc
    mpv
    upower
    i3lock
    rofi
    conky
    gnupg
    pass
    lua
    lua52Packages.luastdlib
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.default = "i3";
  services.xserver.windowManager.i3.enable = true;
  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.jlle = {
    description = "Jose Luis";
    isNormalUser = true;
    home = "/home/jlle";
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      hack-font
      inconsolata
      ubuntu_font_family
      unifont
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      ttf_bitstream_vera
      dejavu_fonts
      freefont_ttf
      powerline-fonts
      font-awesome-ttf
    ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";

}
