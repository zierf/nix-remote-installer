{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            # boot = {
            #   size = "1M";
            #   type = "EF02"; # for grub MBR
            #   priority = 1; # Needs to be first partition
            # };
            ESP = {
              priority = 1;
              name = "ESP";
              # start = "1M";
              # end = "511M";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "relatime"
                    ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd"
                      "relatime"
                    ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  # Subvolume for the swapfile
                  "@swap" = {
                    mountpoint = "/swap";
                    mountOptions = [ "noatime" ];
                    swap = {
                      swapfile.size = "8G";
                      swapfile.path = "swapfile";
                    };
                  };
                };

                mountpoint = "/partition-root";
                # swap = {
                #   swapfile = {
                #     size = "8G";
                #   };
                # };
              };
            };
          };
        };
      };
    };
  };
}
