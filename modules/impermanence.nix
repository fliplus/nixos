{
  flake.nixosModules.core = { config, lib, user, ... }:
  let
    persist = config.preferences.persist;
  in
  {
    boot.initrd.postResumeCommands = lib.mkAfter ''
      zfs rollback -r zroot/local/root@blank
    '';

    fileSystems."/persist".neededForBoot = true;

    environment.persistence."/persist" = {
      hideMounts = true;

      directories = persist.root.directories;
      files = persist.root.files;

      users.${user} = {
        directories = persist.home.directories;
        files = persist.home.files;
      };
    };
  };
}
