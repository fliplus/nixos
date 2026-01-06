{
  flake.nixosModules.core = { config, user, ... }:

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
        };
      };
    };
  };
}
