{ lib, ... }:
{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      programs.git = {
        enable = true;

        config = {
          user = {
            name = "Filipe Abreu";
            email = "134308239+fliplus@users.noreply.github.com";
          };

          core.pager = lib.getExe pkgs.delta;
          interactive.diffFilter = "${lib.getExe pkgs.delta} --color-only";
        };
      };

      environment.systemPackages = with pkgs; [
        lazygit
      ];

      hjem.users.${user}.xdg.config.files."lazygit/config.yml" = {
        generator = (pkgs.formats.yaml { }).generate "config.yml";

        value = {
          git.diffRenderers = [
            {
              command = "${lib.getExe pkgs.delta} --paging=never";
            }
          ];
        };
      };

      preferences.persist.home.directories = [ ".local/state/lazygit" ];
    };
}
