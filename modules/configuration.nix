{
  flake.nixosModules.core =
    { config, ... }:
    let
      inherit (config.preferences.system) host;
    in
    {
      networking.hostName = host;

      time.timeZone = "Europe/Lisbon";
      i18n.defaultLocale = "en_US.UTF-8";

      programs.nano.enable = false;

      preferences.persist = {
        root = {
          directories = [ "/var/lib/nixos" ];

          files = [ "/etc/machine-id" ];
        };

        home.directories = [ "nixos" ];
      };

      system.stateVersion = "26.11";
    };
}
