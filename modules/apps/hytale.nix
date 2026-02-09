{ inputs, ... }:
{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        inputs.hytale-launcher.packages.${stdenv.hostPlatform.system}.default
      ];

      preferences.persist.home.directories = [
        ".local/share/hytale-launcher"
        ".local/share/Hytale"
      ];
    };
}
