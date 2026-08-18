{ inputs, ... }:
{
  flake.nixosModules.core =
    { pkgs, ... }:
    let
      vintagestory = pkgs.vintagestory.overrideAttrs {
        version = "1.22.0";
        src = pkgs.fetchurl {
          url = "https://cdn.vintagestory.at/gamefiles/stable/vs_client_linux-x64_1.22.0.tar.gz";
          hash = "sha256-c90Mb5hyL8StLFrKokAgER/u6l3jhhluP5ErgVs4geI=";
        };
      };
    in
    {
      services.tailscale = {
        enable = true;
        extraUpFlags = [ "--accept-dns=false" ];
      };

      programs.gamemode.enable = true;
      programs.gamescope.enable = true;

      programs.steam = {
        enable = true;
        package = inputs.millennium.packages.${pkgs.stdenv.hostPlatform.system}.default;
        extraCompatPackages = with pkgs; [
          proton-cachyos
        ];
      };

      nixpkgs.config.permittedInsecurePackages = [ "nexusmods-app-unfree-0.21.1" ];

      environment.systemPackages = with pkgs; [
        heroic
        nexusmods-app-unfree
        gale
        vintagestory
      ];

      preferences.persist = {
        root.directories = [ "/var/lib/tailscale" ];

        home.directories = [
          ".local/share/Steam"
          ".steam"
          ".config/millennium"
          ".local/share/millennium"

          ".config/heroic"
          "Games"

          ".local/share/NexusMods.App"

          ".local/share/gale"
          ".local/share/com.kesomannen.gale"

          ".local/share/Terraria"

          ".config/VintagestoryData"
        ];
      };
    };
}
