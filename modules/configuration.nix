{
  flake.nixosModules.core = {
    inputs,
    pkgs,
    host,
    ...
  }: {
    networking.hostName = host;

    networking.networkmanager = {
      enable = true;
      insertNameservers = ["1.1.1.1"];
    };

    time.timeZone = "Europe/Lisbon";

    i18n.defaultLocale = "en_US.UTF-8";

    environment.systemPackages = with pkgs; [
      hyprlauncher
    ];

    programs.git = {
      enable = true;

      config = {
        user = {
          name = "Filipe Abreu";
          email = "134308239+fliplus@users.noreply.github.com";
        };
      };
    };

    services.openssh.enable = true;

    programs.nano.enable = false;

    preferences.persist.root = {
      directories = [
        "/var/lib/nixos"
        "/etc/NetworkManager/system-connections"
      ];

      files = ["/etc/machine-id"];
    };

    preferences.persist.home.directories = [
      "nixos"
    ];

    system.stateVersion = "25.11";
  };
}
