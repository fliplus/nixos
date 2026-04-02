{ inputs, ... }:
{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      environment.systemPackages = with pkgs; [
        inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
        gpu-screen-recorder
      ];

      hjem.users.${user} = {
        rum.desktops.niri = {
          spawn-at-startup = [
            [ "noctalia-shell" ]
          ];

          binds = {
            "Mod+Space".spawn = [
              "noctalia-shell"
              "ipc"
              "call"
              "launcher"
              "toggle"
            ];

            "Mod+G".spawn = [
              "noctalia-shell"
              "ipc"
              "call"
              "bar"
              "toggle"
            ];
          };

          config = ''
            include optional=true "/home/flip/.config/niri/noctalia.kdl"

            layer-rule {
                match namespace="^noctalia-overview*"
                place-within-backdrop true
            }
          '';
        };

        xdg.config.files."ghostty/config" = {
          value.theme = "noctalia";
        };
      };

      preferences.persist.home.directories = [
        ".config/noctalia"
        ".cache/noctalia"

        ".config/niri"
        ".config/ghostty"
      ];
    };
}
