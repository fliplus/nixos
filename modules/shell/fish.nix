{
  flake.nixosModules.core = {
    programs.fish = {
      enable = true;

      shellInit = ''
        set fish_greeting
      '';
    };

    documentation.man.generateCaches = false;

    preferences.persist.home.files = [ ".local/share/fish/fish_history" ];
  };
}
