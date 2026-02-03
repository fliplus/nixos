{
  flake.nixosModules.core = {pkgs, ...}: {
    programs._1password-gui.enable = true;

    programs.ssh.extraConfig = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';

    environment.etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
          zen
        '';
        mode = "0755";
      };
    };

    preferences.auto-start = [
      ["1password" "--silent"]
    ];

    preferences.persist.home.directories = [
      ".config/1Password"
    ];
  };
}
