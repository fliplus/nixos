{
  flake.nixosModules.core =
    {
      config,
      lib,
      pkgs,
      user,
      ...
    }:
    {
      # supress mutiple password options warning
      options.warnings = lib.mkOption {
        apply = lib.filter (
          warning: !(lib.hasInfix "If multiple of these password options are set at the same time" warning)
        );
      };

      config = {
        users = {
          mutableUsers = false;

          users = {
            root = {
              initialPassword = "password";
              hashedPasswordFile = "/persist/password";
            };

            ${user} = {
              isNormalUser = true;

              initialPassword = "password";
              hashedPasswordFile = "/persist/password";

              extraGroups = [ "wheel" ];

              shell = pkgs.fish;
            };
          };
        };

        preferences.persist.home.directories = [
          "Desktop"
          "dev"
          "Downloads"
          "Pictures"
        ];
      };
    };
}
