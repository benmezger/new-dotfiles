# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ./video.nix ];

  boot.initrd.availableKernelModules = [ "vmd" "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" "btrfs" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/8b1fa901-c05b-48c1-a961-a789620601d6";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/8b1fa901-c05b-48c1-a961-a789620601d6";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/02fc10a5-c3f0-45c3-8766-95c9d84a4f60";
      fsType = "ext2";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/56F6-FFB4";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/8b1fa901-c05b-48c1-a961-a789620601d6";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd" "noatime"];
      neededForBoot = true;
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/8b1fa901-c05b-48c1-a961-a789620601d6";
      fsType = "btrfs";
      options = [ "subvol=@persist" "compress=zstd" "noatime"];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/8b1fa901-c05b-48c1-a961-a789620601d6";
      fsType = "btrfs";
      options = [ "subvol=/@/@log" "compress=zstd" "noatime"];
      neededForBoot = true;
    };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/d8b55c56-5a0e-4046-a4cf-097f95bfde6f";
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  virtualisation.virtualbox.guest.enable = true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
