# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, outputs, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./networking.nix
      ./bootloader.nix
      ./x.nix
      ./../../variables.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  services.openssh.enable = true;

  time.timeZone = config.timezone;

  i18n.defaultLocale = config.locale;
  i18n.extraLocaleSettings = config.locale_settings;

  users.users = {
    "${config.username}"= {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "audio"
        "video"
        "plugdev"
        "input"
      ];
      hashedPassword = "8cd824c700eb0c125fff40c8c185d14c5dfe7f32814afac079ba7c20d93bc3c082193243c420fed22ef2474fbb85880e7bc1ca772150a1f759f8ddebca77711f";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFZPZ+lDBETiLkDt5W7KqCwk67b2eTBbRqI923tjVhnS"];
      packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users."${config.username}" = import (builtins.toPath ../../home/default/default.nix);
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
    ripgrep
    acpi
    acpid
    alsa-tools
    alsa-utils
    autoconf
    binutils
    bzip2
    coreutils
    cryptsetup
    dhcpcd
    findutils
    gcc
    libgcc
    gnugrep
    less
    lvm2
    gnumake
    man
    mlocate
    nettools
    gnused
    gnutar
    which
    iucode-tool
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
