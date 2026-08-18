{
  flake.nixosModules.core =
    { config, ... }:
    let
      inherit (config.preferences.system) host;
    in
    {
      networking.hostName = host;

      networking.networkmanager = {
        enable = true;
        insertNameservers = [ "1.1.1.1" ];
      };

      time.timeZone = "Europe/Lisbon";

      i18n.defaultLocale = "en_US.UTF-8";

      programs.nano.enable = false;

      preferences.persist = {
        root = {
          directories = [
            "/var/lib/nixos"
            "/etc/NetworkManager/system-connections"
          ];

          files = [ "/etc/machine-id" ];
        };

        home.directories = [ "nixos" ];
      };

      system.stateVersion = "26.11";
    };
}
