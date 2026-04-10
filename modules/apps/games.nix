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
        nexusmods-app-unfree
        cemu
      ];

      preferences.persist.home.directories = [
        ".local/share/Steam"
        ".steam"
        ".config/millennium"
        ".local/share/millennium"

        ".config/heroic"

        ".local/share/NexusMods.App"

        ".config/Cemu"
        ".local/share/Cemu"

        "Games"
      ];
    };
}
