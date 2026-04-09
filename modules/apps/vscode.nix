{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        vscode.fhs
      ];

      preferences.persist.home.directories = [
        ".vscode"
        ".config/Code"
      ];
    };
}
