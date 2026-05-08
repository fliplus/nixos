{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gimp
      ];

      preferences.persist.home.directories = [ ".config/GIMP" ];
    };
}
