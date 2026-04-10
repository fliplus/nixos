{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        claude-code
      ];

      preferences.persist.home = {
        directories = [
          ".claude"
        ];
        files = [
          ".claude.json"
        ];
      };
    };
}
