{ inputs, ... }:
{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;
      persist = config.preferences.persist;
    in
    {
      imports = [ inputs.impermanence.nixosModules.default ];
      boot.initrd.systemd.services.rollback = {
        description = "Rollback ZFS root to blank snapshot";
        wantedBy = [ "initrd.target" ];
        after = [ "zfs-import-zroot.service" ];
        before = [ "sysroot.mount" ];
        path = [ pkgs.zfs ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          zfs rollback -r zroot/local/root@blank
        '';
      };

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

      security.sudo.extraConfig = "Defaults lecture=never";

      environment.systemPackages = [
        (pkgs.writeShellScriptBin "persist-list" ''
          echo "${builtins.concatStringsSep "\n" (map (d: d + "/") persist.root.directories)}" | sort
          echo
          echo "${builtins.concatStringsSep "\n" persist.root.files}" | sort
          echo
          echo "${
            builtins.concatStringsSep "\n" (map (d: "/home/${user}/" + d + "/") persist.home.directories)
          }" | sort
          echo
          echo "${builtins.concatStringsSep "\n" (map (f: "/home/${user}/" + f) persist.home.files)}" | sort
        '')
      ];
    };
}
