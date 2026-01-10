{
  flake.nixosModules.core = { config, user, ... }:

  {
    services.openssh.enable = true;
    programs.ssh.extraConfig = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';

    services.displayManager.ly = {
      enable = true;

      settings = {
        bigclock = "en";
        bigclock_seconds = true;
	save = true;
        vi_default_mode = "insert";
        vi_mode = true;
      };
    };

    preferences.persist.root.files = [ "/etc/ly/save.txt" ];
    preferences.persist.home.directories = [ ".ssh" ];
  };
}
