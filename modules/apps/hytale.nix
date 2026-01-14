{
  flake.nixosModules.core = { inputs, pkgs, ... }:

  {
    environment.systemPackages = with pkgs; [
      inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    preferences.persist.home.directories = [
      ".local/share/hytale-launcher"
      ".local/share/Hytale"
    ];
  };
}
