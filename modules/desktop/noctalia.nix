{ inputs, lib, ... }:
{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;

      annotateClipboard = pkgs.writeShellScriptBin "noctalia-annotate-clipboard" ''
        file="$XDG_RUNTIME_DIR/noctalia-annotate-clipboard.png"
        wl-paste --type image/png > "$file" || exit 1
        noctalia msg annotate "$file"
      '';
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

      hjem.users.${user}.programs.noctalia = {
        enable = true;

        settings = {
          backdrop.enabled = true;

          bar.default = {
            capsule_group = [
              {
                id = "g1";
                members = [
                  "clipboard"
                  "wallhaven"
                ];
                accordion = true;
                accordion_direction = "start";
              }
            ];
            end = [
              "tray"
              "group:g1"
              "recorder"
              "bluetooth"
              "volume"
              "input_volume"
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

          hooks.started = [ "noctalia msg plugin noctalia/screen_recorder:service all replay-start" ];

          location.auto_locate = true;

          nightlight.enabled = true;

          notification = {
            monitors = [ (lib.last config.preferences.monitors).name ];
            position = lib.mkIf (!config.preferences.system.isLaptop) "top_left";
          };

          osd = {
            monitors = [ (lib.last config.preferences.monitors).name ];
            position = if config.preferences.system.isLaptop then "top_right" else "top_left";

            kinds.media = false;
          };

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
          ];

          shell = {
            corner_radius_scale = 0.75;
            polkit_agent = true;
            screen_time_enabled = true;

            animation.speed = 1.5;

            greeter_sync.auto_sync = true;

            screenshot = {
              confirm_region = true;
              directory = "/home/${user}/Pictures/Screenshots";
            };
          };

          theme.templates.builtin_ids = [
            "gtk3"
            "gtk4"
            "ghostty"
            "luciole"
            "qt"
            "umbriel"
          ];

          wallpaper.directory = "/home/${user}/Pictures/Wallpapers";

          widget = {
            input_volume.show_label = false;

            media.hide_when_no_media = true;

            recorder.type = "noctalia/screen_recorder:recorder";

            sysmon.show_value = false;

            tray.drawer = true;

            volume.show_label = false;

            wallhaven.type = "noctalia/wallhaven:wallhaven";

            workspaces = {
              focused_output_only = true;
              hide_when_empty = true;
              style = "minimal";
            };
          };
        };
      };

      preferences.binds = {
        "Mod+Space".command = "noctalia msg panel-toggle launcher";
        "Mod+G".command = "noctalia msg bar-toggle";
        "Mod+S".command = "noctalia msg screenshot-region";
        "Mod+Shift+S".command = "noctalia msg screenshot-fullscreen";
        "Mod+Z".command = "noctalia msg annotate";
        "Mod+Shift+E" = {
          command = lib.getExe annotateClipboard;
          repeat = false;
        };
        "Mod+Shift+C" = {
          command = "noctalia msg plugin noctalia/screen_recorder:service all replay-save";
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
