{
  flake.nixosModules.core = {pkgs, ...}: {
    programs._1password-gui.enable = true;

    programs.ssh.extraConfig = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';

    preferences.auto-start = [
      ["1password" "--silent"]
    ];

    preferences.persist.home.directories = [
      ".config/1Password"
    ];
  };
}
