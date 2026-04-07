{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        thunar
      ];

      services.tumbler.enable = true;
    };
}
