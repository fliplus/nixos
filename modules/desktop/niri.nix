{ lib, ... }:
{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;

      toggleGapsScript = pkgs.writeShellScriptBin "niri-toggle-gaps" (
        builtins.readFile ./niri-toggle-gaps.sh
      );

      pauseWindowScript = pkgs.writeShellScriptBin "niri-pause-window" (
        builtins.readFile ./niri-pause-window.sh
      );

      forEachWorkspace =
        f: lib.concatMap (m: lib.concatMap (ws: f m ws) m.workspaces) config.preferences.monitors;
    in
    {
      programs.niri.enable = true;

      hjem.users.${user}.rum.desktops.niri = {
        enable = true;

        spawn-at-startup = config.preferences.auto-start;

        config = ''
          prefer-no-csd

          environment {
              NIXOS_OZONE_WL "1"
          }

          ${lib.concatStringsSep "\n" (
            map (monitor: ''
              output "${monitor.name}" {
                  mode "${monitor.resolution}@${toString monitor.refreshRate}"
                  position x=${toString monitor.x} y=${toString monitor.y}
              }
            '') config.preferences.monitors
          )}

          ${lib.concatStringsSep "\n" (
            forEachWorkspace (
              monitor: workspace: [
                ''
                  workspace "${toString workspace}" {
                      open-on-output "${monitor.name}"
                  }
                ''
              ]
            )
          )}

          input {
              keyboard {
                  xkb {
                      options "caps:super, compose:lwin"
                  }
              }

              mouse {
                  accel-profile "flat"
              }

              touchpad {
                tap
                natural-scroll
              }

              focus-follows-mouse max-scroll-amount="50%"
          }

          gestures {
              hot-corners {
                  off
              }
          }

          layout {
              gaps 8

              focus-ring {
                  off
              }

              border {
                  width 2
              }

              background-color "#000000"
          }

          overview {
              backdrop-color "#000000"
          }

          window-rule {
              geometry-corner-radius 12
              clip-to-geometry true
              draw-border-with-background false

              background-effect {
                  blur true
              }
          }

          hotkey-overlay {
              skip-at-startup
          }

          xwayland-satellite {
              path "${lib.getExe pkgs.xwayland-satellite}"
          }

          include optional=true "~/.config/niri/toggles/gaps.kdl"
        '';

        binds = {
          "Mod+Shift+Slash".action = "show-hotkey-overlay";

          "Mod+O" = {
            action = "toggle-overview";
            parameters.repeat = false;
          };

          "Mod+Q" = {
            action = "close-window";
            parameters.repeat = false;
          };
          "Mod+Shift+Q" = {
            spawn = [
              "sh"
              "-c"
              "kill -9 $(niri msg focused-window | awk '/PID:/ {print $2}')"
            ];
            parameters.repeat = false;
          };
          "Mod+Ctrl+X" = {
            spawn = [ (lib.getExe pauseWindowScript) ];
            parameters.repeat = false;
          };

          "Mod+H".action = "focus-column-or-monitor-left";
          "Mod+J".action = "focus-window-or-workspace-down";
          "Mod+K".action = "focus-window-or-workspace-up";
          "Mod+L".action = "focus-column-or-monitor-right";

          "Mod+Shift+H".action = "move-column-left-or-to-monitor-left";
          "Mod+Shift+J".action = "move-window-down-or-to-workspace-down";
          "Mod+Shift+K".action = "move-window-up-or-to-workspace-up";
          "Mod+Shift+L".action = "move-column-right-or-to-monitor-right";

          "Mod+U".action = "focus-monitor-left";
          "Mod+I".action = "focus-monitor-right";

          "Mod+Shift+U".action = "move-window-to-monitor-left";
          "Mod+Shift+I".action = "move-window-to-monitor-right";

          "Mod+WheelScrollDown" = {
            action = "focus-workspace-down";
            parameters.cooldown-ms = 150;
          };
          "Mod+WheelScrollUp" = {
            action = "focus-workspace-up";
            parameters.cooldown-ms = 150;
          };
          "Mod+Ctrl+WheelScrollDown" = {
            action = "move-column-to-workspace-down";
            parameters.cooldown-ms = 150;
          };
          "Mod+Ctrl+WheelScrollUp" = {
            action = "move-column-to-workspace-up";
            parameters.cooldown-ms = 150;
          };

          "Mod+WheelScrollRight".action = "focus-column-right";
          "Mod+WheelScrollLeft".action = "focus-column-left";
          "Mod+Ctrl+WheelScrollRight".action = "move-column-right";
          "Mod+Ctrl+WheelScrollLeft".action = "move-column-left";

          "Mod+Shift+WheelScrollDown".action = "focus-column-right";
          "Mod+Shift+WheelScrollUp".action = "focus-column-left";
          "Mod+Ctrl+Shift+WheelScrollDown".action = "move-column-right";
          "Mod+Ctrl+Shift+WheelScrollUp".action = "move-column-left";

          "Mod+Tab".action = "focus-workspace-previous";

          "Mod+BracketLeft".action = "consume-or-expel-window-left";
          "Mod+BracketRight".action = "consume-or-expel-window-right";

          "Mod+R".action = "switch-preset-column-width";

          "Mod+Shift+R".action = "switch-preset-window-height";
          "Mod+Ctrl+R".action = "reset-window-height";
          "Mod+E".action = "maximize-column";
          "Mod+F".action = "fullscreen-window";
          "Mod+Shift+F".action = "maximize-window-to-edges";

          "Mod+Ctrl+F".action = "expand-column-to-available-width";

          "Mod+C".action = "center-column";

          "Mod+Minus".action = "set-column-width \"-10%\"";
          "Mod+Equal".action = "set-column-width \"+10%\"";

          "Mod+Shift+Minus".action = "set-window-height \"-10%\"";
          "Mod+Shift+Equal".action = "set-window-height \"+10%\"";

          "Mod+V".action = "toggle-window-floating";
          "Mod+Shift+V".action = "switch-focus-between-floating-and-tiling";

          "Mod+W".action = "toggle-column-tabbed-display";

          "Mod+S".action = "screenshot show-pointer=false";
          "Mod+Shift+S".action = "screenshot-window show-pointer=false";
          "Mod+Ctrl+S".action = "screenshot-screen show-pointer=false";

          "Mod+Escape" = {
            action = "toggle-keyboard-shortcuts-inhibit";
            parameters.allow-inhibiting = false;
          };

          "Ctrl+Alt+Delete".action = "quit";

          "Mod+Shift+P".action = "power-off-monitors";

          "Mod+Shift+G" = {
            spawn = [ (lib.getExe toggleGapsScript) ];
            parameters.repeat = false;
          };
        }
        // lib.listToAttrs (
          forEachWorkspace (
            monitor: workspace: [
              {
                name = "Mod+${toString workspace}";
                value.action = ''focus-workspace "${toString workspace}"'';
              }
              {
                name = "Mod+Shift+${toString workspace}";
                value.action = ''move-window-to-workspace "${toString workspace}"'';
              }
            ]
          )
        )
        // lib.listToAttrs (
          map (bind: {
            name = lib.concatStringsSep "+" bind.hotkey;
            value = {
              spawn = bind.command;
              parameters.repeat = bind.repeat;
            };
          }) config.preferences.binds
        );
      };

      preferences.persist.home.directories = [ ".config/niri" ];
    };
}
