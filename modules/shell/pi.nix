{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        pi-coding-agent
      ];

      preferences.persist.home.directories = [ ".pi" ];
    };
}
