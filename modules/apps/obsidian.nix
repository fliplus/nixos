{ lib, ... }:
{
  flake.nixosModules.core =
    { pkgs, ... }:
    let
      remotePath = "icloud:Obsidian/Notes";
      vault = "vault";
    in
    {
      environment.systemPackages = with pkgs; [
        obsidian
      ];

      systemd.user.services.obsidian-sync = {
        description = "Sync ~/${vault} with ${remotePath}";

        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];

        unitConfig.ConditionPathExists = "%h/.config/rclone/rclone.conf";

        serviceConfig = {
          Type = "oneshot";

          ExecStart = builtins.concatStringsSep " " [
            "${lib.getExe pkgs.rclone} bisync %h/${vault} ${remotePath}"
            "--config=%h/.config/rclone/rclone.conf"
            "--conflict-resolve=newer"
            "--resilient"
            "--recover"
            "--max-lock=15m"
            "--log-level=INFO"
          ];
        };
      };

      systemd.user.timers.obsidian-sync = {
        wantedBy = [ "timers.target" ];

        timerConfig = {
          OnStartupSec = "30s";
          OnUnitActiveSec = "5m";
        };
      };

      preferences.persist.home.directories = [
        vault
        ".config/obsidian"
      ];
    };
}
