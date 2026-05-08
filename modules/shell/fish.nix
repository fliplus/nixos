{
  flake.nixosModules.core = {
    programs.fish = {
      enable = true;

      shellInit = ''
        set fish_greeting
      '';
    };

    documentation.man.cache.enable = false;

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      flags = [ "--cmd cd" ];
    };

    preferences.persist.home.files = [
      ".local/share/fish/fish_history"
      ".local/share/zoxide/db.zo"
    ];
  };
}
