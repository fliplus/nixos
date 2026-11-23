{ inputs, lib, ... }:
{
  flake.nixosModules.core =
    { config, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      imports = [ inputs.umbriel.nixosModules.default ];

      nix.settings = {
        extra-substituters = [ "https://umbriel.cachix.org" ];
        extra-trusted-public-keys = [ "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw=" ];
      };

      programs.umbriel.enable = true;

      hjem.extraModules = [ inputs.umbriel.hjemModules.default ];

      hjem.users.${user}.programs.umbriel = {
        enable = true;

        settings = {
          include.optional.files = [ "noctalia.toml" ];

          general = {
            autostart = config.preferences.auto-start;
            show_cheatsheet = false;
          };

          input.focus = {
            follows_mouse = "sloppy";
            follows_mouse_max_scroll = 0.5;
          };

          output = lib.listToAttrs (
            map (monitor: {
              inherit (monitor) name;
              value = {
                mode = "${monitor.resolution}@${toString monitor.refreshRate}";
                inherit (monitor) scale;
                position = [
                  monitor.x
                  monitor.y
                ];
                workspaces = 9;
              }
              // lib.optionalAttrs (monitor == lib.head config.preferences.monitors) {
                focus_at_startup = true;
              };
            }) config.preferences.monitors
          );

          input.keyboard.options = "caps:super, compose:lwin";

          input.touchpad.natural_scroll = true;

          appearance.border_width = 1;

          layout.gap = 4;

          window_rule = [
            {
              blur = true;
            }
            {
              match.layout = "stacking";
              title_bar = "on";
            }

            {
              match.app_id = "^dev.noctalia.Noctalia$";
              default_floating = true;
              default_floating_size_px = {
                width = 1020;
                height = 900;
              };
            }
            {
              match.app_id = "^dev.noctalia.UmbrielSharePicker$";
              default_floating = true;
              default_floating_size_px = {
                width = 800;
                height = 600;
              };
            }
            {
              match.title = "^(Picture-in-Picture|Picture in picture)$";
              default_floating = true;
              default_maximize = false;
              default_position = {
                x = 20;
                y = 20;
                anchor = "bottom_right";
              };
            }
            {
              match.title = "^notificationtoasts_.+_desktop";
              default_position = {
                x = 0;
                y = 0;
                anchor = "bottom_right";
              };
              default_focused = false;
              default_pinned = true;
            }
          ];

          layer_rule = [
            {
              match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd|desktop-widget-[^\"]*)$";
              blur = true;
              blur_ignore_alpha = 0.5;
              blur_popups = true;
            }
          ];

          keybinds = {
            "Mod+Q" = {
              action = "window-close";
              repeat = false;
            };
            "Mod+Escape" = "session-quit";
            "Mod+Slash" = "cheatsheet-toggle";

            "Mod+O" = "overview-toggle";

            "Mod+H" = "window-focus-left";
            "Mod+J" = "window-focus-down";
            "Mod+K" = "window-focus-up";
            "Mod+L" = "window-focus-right";
            "Mod+Shift+H" = "column-move-left";
            "Mod+Shift+J" = "window-move-down";
            "Mod+Shift+K" = "window-move-up";
            "Mod+Shift+L" = "column-move-right";

            "Mod+WheelUp" = "window-focus-left";
            "Mod+WheelDown" = "window-focus-right";
            "Mod+Shift+WheelUp" = "workspace-previous";
            "Mod+Shift+WheelDown" = "workspace-next";

            "Mod+Alt+H" = "column-focus-tab-previous";
            "Mod+Alt+L" = "column-focus-tab-next";

            "Mod+Comma" = "window-consume-or-expel-left";
            "Mod+Period" = "window-consume-or-expel-right";
            "Mod+Shift+Comma" = "window-consume-from-left";
            "Mod+Shift+Period" = "window-consume-from-right";

            "Mod+U" = "output-focus-left";
            "Mod+I" = "output-focus-right";
            "Mod+Shift+U" = "column-move-to-output-left";
            "Mod+Shift+I" = "column-move-to-output-right";

            "Alt+Tab" = "spawn noctalia msg window-switcher hold";
            "Alt+Shift+Tab" = "spawn noctalia msg window-switcher hold reverse";

            "Mod+C" = "window-center";

            "Mod+V" = "window-toggle-floating";
            "Mod+Shift+V" = "window-focus-switch-floating";
            "Mod+P" = "window-toggle-pinned";

            "Mod+E" = "window-toggle-maximize";
            "Mod+F" = "window-toggle-fullscreen";
            "Mod+Shift+F" = "window-toggle-maximize-to-edges";

            "Mod+R" = "window-cycle-primary-extent";
            "Mod+Shift+R" = "window-cycle-primary-extent-back";

            "Mod+Minus" = "window-modify-primary-extent -0.02";
            "Mod+Equal" = "window-modify-primary-extent +0.02";
            "Mod+Shift+Minus" = "window-modify-secondary-extent -0.02";
            "Mod+Shift+Equal" = "window-modify-secondary-extent +0.02";

            "Mod+W" = "column-toggle-tabbed";

            "Mod+A" = "scratchpad-toggle";
            "Mod+Shift+A" = "window-move-to-scratchpad";
            "Mod+Ctrl+A" = "window-restore-from-scratchpad";
          }
          // lib.mergeAttrsList (
            map (ws: {
              "Mod+${ws}" = "workspace-switch ${ws}";
              "Mod+Shift+${ws}" = "window-move-to-workspace ${ws}";
            }) (map toString (lib.range 1 9))
          )
          // lib.mapAttrs (_: bind: {
            action = "spawn ${bind.command}";
            inherit (bind) repeat;
          }) config.preferences.binds;
        };
      };
    };
}
