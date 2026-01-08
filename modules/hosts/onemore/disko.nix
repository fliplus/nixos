# https://github.com/saygo-png/nixos/blob/99aa51a11f9d9af04e99246202f6e7a3ccc0cf3b/hosts/pc/disko-config.nix
{
  flake.nixosModules.disko-onemore = {
    disko.devices = {
      disk = {
        main = {
          device = "/dev/disk/by-id/nvme-Samsung_SSD_990_PRO_1TB_S7HDNF0Y522080F";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = ["umask=0077"];
                };
              };

              swap = {
                size = "16G";
                type = "8200";
                content = {
                  type = "swap";
                  discardPolicy = "both";
                  resumeDevice = true;
                };
              };

              zfs = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "zroot";
                };
              };
            };
          };
        };
      };

      zpool = {
        zroot = {
          type = "zpool";
          rootFsOptions = {
            # https://wiki.archlinux.org/title/Install_Arch_Linux_on_ZFS
            acltype = "posixacl";
            atime = "off";
            compression = "zstd";
            mountpoint = "none";
            xattr = "sa";
          };
          options = {
            ashift = "12";
            autotrim = "on";
          };

          datasets = {
            "local" = {
              type = "zfs_fs";
              options.mountpoint = "none";
            };

            "local/root" = {
              type = "zfs_fs";
              mountpoint = "/";
              options."com.sun:auto-snapshot" = "false";
              postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot/local/root@blank$' || zfs snapshot zroot/local/root@blank";
            };

            "local/nix" = {
              type = "zfs_fs";
              mountpoint = "/nix";
              options."com.sun:auto-snapshot" = "false";
            };

            "local/cache" = {
              type = "zfs_fs";
              mountpoint = "/cache";
              options."com.sun:auto-snapshot" = "false";
            };

            "local/persist" = {
              type = "zfs_fs";
              mountpoint = "/persist";
              options."com.sun:auto-snapshot" = "false";
            };
          };
        };
      };
    };

    services.zfs.autoScrub.enable = true;

    # https://github.com/openzfs/zfs/issues/10891
    systemd.services.systemd-udev-settle.enable = false;
  };
}
