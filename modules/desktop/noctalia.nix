{ inputs, lib, ... }:
{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;

      barSmartToggleScript = pkgs.writeShellScriptBin "noctalia-bar-smart-toggle" (
        builtins.readFile ./noctalia-bar-smart-toggle.sh
      );
    in
    {
      nix.settings = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
      };

      imports = [
        inputs.noctalia.nixosModules.default
      ];

      programs.noctalia = {
        enable = true;
        systemd.enable = true;
      };

      environment.systemPackages = with pkgs; [
        gpu-screen-recorder
      ];

      hjem.users.${user} = {
        rum.desktops.niri = {
          binds = {
            "Mod+Space".spawn = [
              "noctalia"
              "msg"
              "panel-toggle"
              "launcher"
            ];

            "Mod+G".spawn = [
              "noctalia"
              "msg"
              "bar-toggle"
            ];

            "Mod+Ctrl+G" = {
              spawn = [ (lib.getExe barSmartToggleScript) ];
              parameters.repeat = false;
            };
          };

          config = ''
            include optional=true "/home/flip/.config/niri/noctalia.kdl"

            layer-rule {
                match namespace="^noctalia-backdrop"
                place-within-backdrop true
            }

            debug {
                honor-xdg-activation-with-invalid-serial
            }
          '';
        };

        xdg.config.files."ghostty/config" = {
          value.theme = "noctalia";
        };
      };

      preferences.persist.home.directories = [
        ".config/noctalia"
        ".local/state/noctalia"
        ".cache/noctalia"

        ".config/niri"
        ".config/ghostty"
      ];
    };
}
