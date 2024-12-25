{ config, lib, pkgs, ... }:

{
  boot = {
    kernelParams = ["module_blacklist=i915"];
    supportedFilesystems = ["btrfs"];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        useOSProber = true;
        enable = true;
        device = "nodev";
        efiSupport = true;
        enableCryptodisk = true;
        gfxmodeEfi = "1920x1440";
      };
    };
    initrd.luks.devices = {
      cryptroot = {
        # Use https://nixos.wiki/wiki/Full_Disk_Encryption
        device = "/dev/disk/by-uuid/d4dd9554-893b-40c3-b81e-1fbf38e81392";
        preLVM = true;
      };
    };
  };
}
