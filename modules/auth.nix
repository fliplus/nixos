{
  flake.nixosModules.core = {
    config,
    user,
    ...
  }: {
    services.openssh.enable = true;

    services.displayManager = {
      ly = {
        enable = true;

        settings = {
          bigclock = "en";
          save = true;
          vi_default_mode = "insert";
          vi_mode = true;
        };
      };

      autoLogin = {
        enable = true;
        inherit user;
      };
      sessionData.autologinSession = "niri";
    };

    preferences = {
      persist.root.files = ["/etc/ly/save.txt"];
      persist.home.directories = [".ssh"];
    };
  };
}
