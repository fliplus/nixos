{
  flake.nixosModules.host-framework = {
    networking.hostId = "c915d58c";

    preferences.monitors = [
      {
        name = "eDP-1";
        resolution = "2560x1600";
        refreshRate = 165.000;
        x = 0;
        y = 0;
      }
    ];

    networking.resolvconf.dnsExtensionMechanism = false;
  };
}
