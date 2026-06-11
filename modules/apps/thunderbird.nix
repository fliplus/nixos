{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        thunderbird
      ];

      preferences.persist.home.directories = [
        ".thunderbird"
      ];
    };
}
