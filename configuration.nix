{
  modulesPath,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  boot.loader = {
    # grub = {
    #   # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    #   # devices = [
    #   #   "/dev/vda"
    #   # ];
    #   efiSupport = true;
    #   efiInstallAsRemovable = true;
    # };

    systemd-boot = {
      enable = true;
      memtest86.enable = true;
    };
    efi.canTouchEfiVariables = true;
  };

  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gptfdisk
    pkgs.gitMinimal
    pkgs.nano
    pkgs.vim
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    # ssh public key
    "ssh-ed25519 AAAAC3e7n4dbR25rA8pARJMPJYKXSXq1855Ki1A3H3HqE1Gy6FG3n1k1Mmy3+cB7K9zG 9168602+zierf@users.noreply.github.com"
  ];

  nix = {
    settings = {
      # https://nixos.wiki/wiki/Nix_command
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # https://nixos.wiki/wiki/Storage_optimization
      auto-optimise-store = true;
    };
  };

  system.stateVersion = "24.05";
}
