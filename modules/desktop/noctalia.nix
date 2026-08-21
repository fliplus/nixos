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
      imports = [ inputs.noctalia.nixosModules.default ];

      nix.settings = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
      };

      programs.noctalia = {
        enable = true;
        systemd.enable = true;
      };

      environment.systemPackages = with pkgs; [
        gpu-screen-recorder
      ];

      hjem.extraModules = [ inputs.noctalia.hjemModules.default ];

      hjem.users.${user} = {
        programs.noctalia = {
          enable = true;

          settings = {
            backdrop.enabled = true;

            bar.default = {
              background_opacity = 0.85;
              end = [
                "tray"
                "nix-monitor"
                "clipboard"
                "recorder"
                "bluetooth"
                "volume"
                "control-center"
              ];
              margin_ends = 0;
              padding = 6;
              radius = 0;
              start = [
                "workspaces"
                "sysmon"
                "ram"
                "media"
              ];
              thickness = 24;
            };

            control_center.calendar.show_events_card = false;

            location.auto_locate = true;

            nightlight.enabled = true;

            notification = {
              monitors = [ (lib.last config.preferences.monitors).name ];
              position = if config.preferences.system.isLaptop then "top_right" else "top_left";
            };

            osd.kinds.media = false;

            plugin_settings."noctalia/screen_recorder" = {
              audio_source = "both";
              copy_to_clipboard = true;
              replay_duration = 60;
              replay_enabled = true;
              restore_portal = true;
            };

            plugins.enabled = [
              "noctalia/wallhaven"
              "noctalia/screen_recorder"
              "cleboost/jetbrains-provider"
              "radimous/prismlauncher-instances"
              "avivbintangaringga/nix-monitor"
            ];

            shell = {
              polkit_agent = true;
              screen_time_enabled = true;

              animation.speed = 1.5;

              panel.transparency_mode = "soft";
            };

            theme.templates.builtin_ids = [
              "gtk3"
              "gtk4"
              "ghostty"
              "niri"
              "qt"
            ];

            widget = {
              media.hide_when_no_media = true;

              "nix-monitor" = {
                colorize_glyph = false;
                show_text = false;
                type = "avivbintangaringga/nix-monitor:nix-monitor";
              };

              recorder.type = "noctalia/screen_recorder:recorder";

              sysmon.show_value = false;

              tray.drawer = true;

              volume.show_label = false;

              workspaces = {
                focused_output_only = true;
                hide_when_empty = true;
                label_source = "name";
                style = "minimal";
              };
            };
          };
        };

        rum.desktops.niri.config = ''
          include optional=true "/home/${user}/.config/niri/noctalia.kdl"

          layer-rule {
              match namespace="^noctalia-backdrop"
              place-within-backdrop true
          }

          debug {
              honor-xdg-activation-with-invalid-serial
          }
        '';

        xdg.config.files."ghostty/config" = {
          value.theme = "noctalia";
        };
      };

      preferences.binds = {
        "Mod+Space".command = "noctalia msg panel-toggle launcher";
        "Mod+G".command = "noctalia msg bar-toggle";
        "Mod+Ctrl+G" = {
          command = lib.getExe barSmartToggleScript;
          repeat = false;
        };
      };

      preferences.persist.home.directories = [
        ".config/noctalia"
        ".local/state/noctalia"
        ".cache/noctalia"
      ];
    };
}
