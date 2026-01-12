{
  flake.nixosModules.core = { inputs, lib, pkgs, ... }:
  let
    inherit (inputs.nix-jetbrains-plugins.lib) pluginsForIde;

    plugins = lib.attrValues (pluginsForIde pkgs "idea" [
      "IdeaVIM"
      "dev.azn9.plugins.discord"
      "com.demonwav.minecraft-dev"
      "dev.kikugie.stonecutter"
    ]);
  in
  {
    environment.systemPackages = with pkgs; [
      (jetbrains.plugins.addPlugins (jetbrains.idea.override { forceWayland = true; }) plugins)
    ];

    preferences.persist.home.directories = [
      ".config/JetBrains"
      ".local/share/JetBrains"
      ".cache/JetBrains"
      ".java/.userPrefs/"
    ];
  };
}
