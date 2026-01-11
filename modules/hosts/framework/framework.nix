{
  flake.nixosModules.host-framework = {
    preferences.monitors = [
      {
        name = "eDP-1";
        resolution = "2560x1600";
        refreshRate = 165;
        position = "0x0";
      }
    ];

    networking.resolvconf.dnsExtensionMechanism = false;

    networking.hostId = "c915d58c";
  };
}
