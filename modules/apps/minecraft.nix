{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        (prismlauncher.override {
          jdks = [
            javaPackages.compiler.temurin-bin.jdk-8
            javaPackages.compiler.temurin-bin.jdk-17
            javaPackages.compiler.temurin-bin.jdk-21
            javaPackages.compiler.temurin-bin.jdk-25
          ];

          additionalLibs = [
            libxtst
            libxkbcommon
            libxt
            libxinerama
          ];
        })

        waywall
        packwiz
      ];

      preferences.persist.home.directories = [
        ".local/share/PrismLauncher"
        ".config/waywall"
      ];
    };
}
