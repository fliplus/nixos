{
  flake.nixosModules.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      code-cursor
    ];

    preferences.persist.home.directories = [
      ".config/Cursor"
      ".cursor"
    ];
  };
}
