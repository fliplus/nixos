{
  flake.nixosModules.core = {
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
      [
        "1password"
        "--silent"
      ]
    ];

    preferences.binds = [
      {
        hotkey = [
          "Mod"
          "Shift"
          "Space"
        ];
        command = [
          "1password"
          "--quick-access"
        ];
      }
    ];

    preferences.persist.home.directories = [
      ".config/1Password"
    ];
  };
}
