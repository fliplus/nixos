{
  flake.nixosModules.core = {
    programs.fish = {
      enable = true;

      shellInit = ''
        set fish_greeting
      '';
    };

    preferences.persist.home.files = [ ".local/share/fish/fish_history" ];
  };
}
