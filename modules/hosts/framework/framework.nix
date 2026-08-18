{ config, ... }:
{
  flake.nixosModules.host-framework = {
    imports = with config.flake.nixosModules; [ quartus ];

    networking.hostId = "c915d58c";

    preferences.monitors = [
      {
        name = "eDP-1";
        resolution = "2560x1600";
        refreshRate = 165.000;
        x = 0;
        y = 0;
        workspaces = [
          1
          2
          3
          4
          5
          6
          7
          8
          9
        ];
      }
    ];

    networking.resolvconf.dnsExtensionMechanism = false;
  };
}
