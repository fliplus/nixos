{ lib, ... }:
{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      environment.systemPackages = with pkgs; [
        ghostty
      ];

      hjem.users.${user}.xdg.config.files."ghostty/config" = {
        generator = lib.generators.toKeyValue {
          mkKeyValue = lib.generators.mkKeyValueDefault { } " = ";
        };

        value = {
          window-padding-x = 4;
          window-padding-y = 4;
          confirm-close-surface = false;
          shell-integration-features = "ssh-terminfo,ssh-env";

          custom-shader = "${./cursor_smear.glsl}";
        };
      };

      preferences.binds."Mod+T".command = "ghostty";
    };
}
