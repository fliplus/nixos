{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        claude-code
        sox
      ];

      preferences.persist.home = {
        directories = [ ".claude" ];

        files = [ ".claude.json" ];
      };
    };
}
