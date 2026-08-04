{ lib, ... }:
{
  flake.nixosModules.core =
    {
      config,
      pkgs,
      ...
    }:
    let
      inherit (config.preferences.system) user;

      jdks = with pkgs.javaPackages.compiler.temurin-bin; {
        "25" = jdk-25;
        "21" = jdk-21;
        "17" = jdk-17;
        "8" = jdk-8;
      };
    in
    {
      environment.systemPackages = with pkgs; [
        jetbrains.idea
        jetbrains.ruby-mine

        jdks."25"
      ];

      hjem.users.${user}.files = lib.mapAttrs' (
        version: jdk: lib.nameValuePair ".jdks/temurin-${version}" { source = jdk; }
      ) jdks;

      preferences.persist.home.directories = [
        ".config/JetBrains"
        ".local/share/JetBrains"
        ".cache/JetBrains"

        ".java/.userPrefs"
        ".gradle"
      ];
    };
}
