{ lib, ... }:
{
  flake.nixosModules.core =
    { pkgs, ... }:
    let
      remote = "icloud";
      mountPoint = "iCloud";
    in
    {
      environment.systemPackages = with pkgs; [
        rclone
      ];

      programs.fuse.enable = true;

      systemd.user.services."rclone-${remote}" = {
        description = "Mount ${remote} at ~/${mountPoint}";

        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        wantedBy = [ "default.target" ];

        path = [ "/run/wrappers" ];

        unitConfig.ConditionPathExists = "%h/.config/rclone/rclone.conf";

        serviceConfig = {
          Type = "notify";

          ExecStartPre = "${lib.getExe' pkgs.coreutils "mkdir"} -p %h/${mountPoint}";

          ExecStart = builtins.concatStringsSep " " [
            "${lib.getExe pkgs.rclone} mount ${remote}: %h/${mountPoint}"
            "--config=%h/.config/rclone/rclone.conf"
            "--cache-dir=%h/.cache/rclone"
            "--vfs-cache-mode=full"
            "--log-level=INFO"
          ];

          ExecStop = "/run/wrappers/bin/fusermount3 -uz %h/${mountPoint}";

          Restart = "on-failure";
          RestartSec = 30;
        };
      };

      preferences.persist.home.directories = [
        ".config/rclone"
        ".cache/rclone"
      ];
    };
}
