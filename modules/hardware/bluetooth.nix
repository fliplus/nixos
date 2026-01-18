{
  flake.nixosModules.core = {
    hardware.bluetooth.enable = true;

    services.blueman.enable = true;

    preferences.persist.root.directories = [ "/var/lib/bluetooth" ];
  };
}
