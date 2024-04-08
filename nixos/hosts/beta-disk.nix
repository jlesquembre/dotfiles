{ lib, ... }:
{
  boot.supportedFilesystems = [ "bcachefs" ];

  disko.devices = {
    disk.nvme0 = {
      device = "/dev/disk/by-path/pci-0000:04:00.0-nvme-1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          # Legacy MBR
          # boot = {
          #   name = "boot";
          #   size = "1M";
          #   type = "EF02";
          # };
          ESP = {
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
            end = "-0"; # Same as size = "100%"
            content = {
              type = "filesystem";
              format = "bcachefs";
              mountpoint = "/";

              # See https://github.com/nix-community/disko/blob/0a17298c0d96190ef3be729d594ba202b9c53beb/lib/types/filesystem.nix#L44-L50
              # Options to mkfs.bcachefs
              extraArgs = [
                # "-f" # force, not needed
                "--compression=lz4"
                "--discard" # TRIM support
                # "--encrypted"
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
