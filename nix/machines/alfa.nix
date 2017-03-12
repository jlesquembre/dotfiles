
{ config, pkgs, ... }:

{

  hardware.opengl.driSupport32Bit = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  #boot.blacklistedKernelModules = [ "nouveau" ];
  #boot.kernelParams = [ "nomodeset" "video=vesa:off" "vga=normal" ];
  #boot.vesa = false;

  #hardware.opengl.enable = true;
  #hardware.opengl.driSupport32Bit = true;
  #services.xserver.videoDrivers = [ "nvidia" "vesa" ];


  #fileSystems."/tmp" = {
  #  device = "tmpfs";
  #  fsType = "tmpfs";
  #  neededForBoot = true;
  #};
  fileSystems."/data" =
    { device = "/dev/disk/by-uuid/ed73e8a3-4a43-4545-b464-c62e31e2b097";
      fsType = "ext4";
    };


  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sdc";

  boot.loader.grub.extraEntries = ''
menuentry 'Arch Linux' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-simple-ed50fb2d-5e65-4ced-8229-fa83dffc8e8e' {
  if [ x$feature_all_video_module = xy ]; then
    insmod all_video
  else
    insmod efi_gop
    insmod efi_uga
    insmod ieee1275_fb
    insmod vbe
    insmod vga
    insmod video_bochs
    insmod video_cirrus
  fi
	set gfxpayload=keep
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='hd1,msdos1'
	if [ x$feature_platform_search_hint = xy ]; then
	  search --no-floppy --fs-uuid --set=root --hint-bios=hd1,msdos1 --hint-efi=hd1,msdos1 --hint-baremetal=ahci1,msdos1  f328d967-9f2a-46e1-9179-05fa334f69b3
	else
	  search --no-floppy --fs-uuid --set=root f328d967-9f2a-46e1-9179-05fa334f69b3
	fi
	echo	'Loading Linux linux ...'
	linux	/vmlinuz-linux root=UUID=ed50fb2d-5e65-4ced-8229-fa83dffc8e8e rw  quiet
	echo	'Loading initial ramdisk ...'
	initrd	/intel-ucode.img /initramfs-linux.img
}

menuentry 'Windows 7 (loader) (on /dev/sda1)' --class windows --class os $menuentry_id_option 'osprober-chain-C848FF1848FF03CA' {
	insmod part_msdos
	insmod ntfs
	set root='hd0,msdos1'
	if [ x$feature_platform_search_hint = xy ]; then
	  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci0,msdos1  C848FF1848FF03CA
	else
	  search --no-floppy --fs-uuid --set=root C848FF1848FF03CA
	fi
	chainloader +1
}

'';


}
