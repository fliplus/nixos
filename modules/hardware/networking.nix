{
  flake.nixosModules.core = {
    networking.networkmanager = {
      enable = true;
      insertNameservers = [ "1.1.1.1" ];
    };

    preferences.persist.root.directories = [ "/etc/NetworkManager/system-connections" ];
  };
}
