{
  flake.nixosModules.core = { pkgs, ... }:

  {
    programs.gamemode.enable = true;

    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    preferences.persist.home.directories = [ ".local/share/Steam" ];
  };
}