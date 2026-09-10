{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        devenv
      ];

      preferences.persist.home.directories = [ ".local/share/devenv" ];
    };
}
