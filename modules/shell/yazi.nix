{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      programs.yazi.enable = true;

      environment.systemPackages = with pkgs; [
        trash-cli
      ];

      preferences.persist.home.directories = [ ".local/share/Trash" ];
    };
}
