{
  flake.nixosModules.core = { config, lib, ... }:

  {
    boot.loader = {
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

    boot.kernelParams = lib.forEach config.preferences.monitors (monitor:
      "video=${monitor.name}:${monitor.resolution}@${toString monitor.refreshRate}"
    );
  };
}
