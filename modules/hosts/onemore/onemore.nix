{
  flake.nixosModules.host-onemore = {
    networking.hostId = "8425e349";

    preferences.monitors = [
      {
        name = "HDMI-A-1";
        resolution = "1920x1080";
        refreshRate = 240;
        x = 0;
        y = 0;
      }
      {
        name = "DP-3";
        resolution = "1920x1080";
        refreshRate = 144;
        x = 1920;
        y = 0;
      }
    ];

    boot.kernelModules = [ "amdgpu" ];

    environment.etc."libinput/local-overrides.quirks".text = ''
      [Never Debounce]
      MatchUdevType=mouse
      ModelBouncingKeys=1
    '';

    fileSystems."/mnt/Games" = {
      device = "/dev/disk/by-label/Games";
      fsType = "ext4";
      options = [
        "nofail"
        "x-gvfs-show"
      ];
    };

    fileSystems."/mnt/Storage" = {
      device = "/dev/disk/by-label/Storage";
      fsType = "ext4";
      options = [
        "nofail"
        "x-gvfs-show"
      ];
    };
  };
}
