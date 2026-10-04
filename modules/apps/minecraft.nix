{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        (prismlauncher.override {
          jdks = with javaPackages.compiler.temurin-bin; [
            jdk-8
            jdk-17
            jdk-21
            jdk-25
          ];

          additionalLibs = [
            libxtst
            libxkbcommon
            libxt
            libxinerama
            fontconfig
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
