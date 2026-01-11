{
  flake.nixosModules.core = { config, pkgs, user, ... }:

  {
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
    ];
  };
}
