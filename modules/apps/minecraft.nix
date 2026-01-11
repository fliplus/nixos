{
  flake.nixosModules.core = { inputs, pkgs, ... }:

  {
    environment.systemPackages = with pkgs; [
      (prismlauncher.override {
        jdks = [ javaPackages.compiler.temurin-bin.jdk-25 ];
      })
      packwiz
    ];

    preferences.persist.home.directories = [ ".local/share/PrismLauncher" ];
  };
}
