{ config, inputs, pkgs, lib, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  # Generated from nixos-generate-config
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/"; # FIXME
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/"; # FIXME
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  # NixOS Hyprland Program
  programs.hyprland = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    kitty
  ];

  # NVidia
  hardware = {
    nvidia = {
      powerManagement.enable = true;
      powerManagement.finegrained = false;

      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      gsp.enable = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.kernelParams = [
    "nvidia.NVreg_UsePageAttributeTable=1"
    "video=DP-2:D" # https://docs.kernel.org/fb/modedb.html
    "video=DP-3:D"
  ];

  users.mutableUsers = false;
  users.users.dragon = {
    description = ""; # FIXME
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
    initialHashedPassword = ""; # FIXME
  };

  system.stateVersion = "24.05";
}
