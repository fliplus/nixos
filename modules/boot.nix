{
  flake.nixosModules.core = {
    config,
    lib,
    pkgs,
    ...
  }: {
    boot = {
      loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };
        grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
          useOSProber = true;
        };
      };

      kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

      kernelParams = lib.forEach config.preferences.monitors (
        monitor: "video=${monitor.name}:${monitor.resolution}@${toString monitor.refreshRate}"
      );

      zfs.package = pkgs.zfs_unstable;
    };
  };
}
