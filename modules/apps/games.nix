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

    environment.systemPackages = with pkgs; [
      heroic
    ];

    preferences.persist.home.directories = [
      ".local/share/Steam"
      ".config/heroic"
      "Games"
    ];
  };
}