{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        jetbrains.idea
        jetbrains.ruby-mine

        javaPackages.compiler.temurin-bin.jdk-25
      ];

      preferences.persist.home.directories = [
        ".config/JetBrains"
        ".local/share/JetBrains"
        ".cache/JetBrains"

        ".java/.userPrefs"
        ".gradle"
      ];
    };
}
