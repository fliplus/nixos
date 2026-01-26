{
  flake.nixosModules.host-onemore = {
    networking.hostId = "8425e349";

    preferences.monitors = [
      {
        name = "HDMI-A-1";
        resolution = "1920x1080";
        refreshRate = 240;
        position = "0x0";
        workspaces = [1 2 3 4 5 6 7];
      }
      {
        name = "DP-3";
        resolution = "1920x1080";
        refreshRate = 144;
        position = "1920x0";
        workspaces = [8 9 10];
      }
    ];

    boot.kernelModules = ["amdgpu"];

    environment.etc."libinput/local-overrides.quirks".text = ''
      [Never Debounce]
      MatchUdevType=mouse
      ModelBouncingKeys=1
    '';
  };
}
