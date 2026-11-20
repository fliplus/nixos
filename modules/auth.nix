{
  flake.nixosModules.core =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (config.preferences.system) user;
    in
    {
      services.openssh.enable = true;

      services.displayManager.noctalia-greeter = {
        enable = true;

        passwordlessSyncUsers = [ user ];

        cursorTheme = {
          package = pkgs.kdePackages.breeze;
          name = "Breeze_Light";
        };

        settings = {
          cursor.size = 24;

          output.refresh_rate = lib.concatMapStringsSep "; " (
            m: "${m.name}:${toString m.refreshRate}"
          ) config.preferences.monitors;
        };
      };

      services.greetd.settings.initial_session = {
        inherit user;
        command = "${config.programs.umbriel.package}/bin/start-umbriel";
      };

      preferences.persist = {
        root.directories = [ "/var/lib/noctalia-greeter" ];

        home.directories = [ ".ssh" ];
      };
    };
}
