{
  flake.nixosModules.core = {
    services.gvfs.enable = true;

    preferences.persist.home.directories = [ ".local/share/Trash" ];
  };
}
