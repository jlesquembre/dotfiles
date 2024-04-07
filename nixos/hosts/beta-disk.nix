{ lib, ... }:
{
  boot.supportedFilesystems = [ "bcachefs" ];

  disko.devices = {
    disk.disk1 = {
      device = "pci-0000:04:00.0-nvme-1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "pool";
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "bcachefs";
              mountpoint = "/";
              # mountOptions = [
              #   "defaults"
              # ];

              # See https://github.com/nix-community/disko/blob/0a17298c0d96190ef3be729d594ba202b9c53beb/lib/types/filesystem.nix#L44-L50
              # Options to mkfs.bcachefs
              extraArgs = [
                # "-f" force, note needed
                "--compression=lz4"
                "--discard" # TRIM support
                "--encrypted"
              ];

              # https://github.com/nix-community/disko/blob/0a17298c0d96190ef3be729d594ba202b9c53beb/lib/types/filesystem.nix#L54-L66
              # https://github.com/nix-community/disko/blob/0a17298c0d96190ef3be729d594ba202b9c53beb/lib/types/filesystem.nix#L71-L74
              # Options to mount command and to fileSystems.<name>.options
              mountOptions = [
                "defaults"
                "compression=lz4"
                "discard"
              ];
            };
          };
        };
      };
    };
  };
}
