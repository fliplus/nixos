{ inputs, ... }:
{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      programs.gamemode.enable = true;
      programs.gamescope.enable = true;

      programs.steam = {
        enable = true;
        package = inputs.millennium.packages.${pkgs.stdenv.hostPlatform.system}.default;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };

      nixpkgs.config.permittedInsecurePackages = [
        "nexusmods-app-unfree-0.21.1"
      ];

      environment.systemPackages = with pkgs; [
        heroic
        cemu
        nexusmods-app-unfree
        gale
      ];

      preferences.persist.home.directories = [
        ".local/share/Steam"
        ".steam"
        ".config/millennium"
        ".local/share/millennium"

        ".config/heroic"
        "Games"

        ".config/Cemu"
        ".local/share/Cemu"

        ".local/share/NexusMods.App"

        ".local/share/gale"
        ".local/share/com.kesomannen.gale"

        ".local/share/Terraria"
      ];
    };
}
