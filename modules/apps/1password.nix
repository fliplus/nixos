{
  flake.nixosModules.core = {
    programs._1password-gui.enable = true;

    programs.ssh.extraConfig = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';

    preferences.auto-start = [ "1password --silent" ];

    preferences.binds."Mod+Shift+Space".command = "1password --quick-access";

    preferences.persist.home.directories = [ ".config/1Password" ];
  };
}
