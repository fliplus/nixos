{ inputs, ... }:
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

        inputs.bedrock-on-linux.packages.${pkgs.stdenv.hostPlatform.system}.default

        waywall
        packwiz
      ];

      preferences.persist.home.directories = [
        ".local/share/PrismLauncher"
        ".config/waywall"
        ".config/bedrock-on-linux"
        ".local/share/bedrock-on-linux"
      ];
    };
}
