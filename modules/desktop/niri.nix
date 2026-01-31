{
  flake.nixosModules.core = {
    inputs,
    config,
    lib,
    pkgs,
    user,
    ...
  }: {
    programs.niri = {
      enable = true;
      package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    hjem.users.${user}.rum.desktops.niri = {
      enable = true;

      binds = {
        "Mod+Shift+Slash".action = "show-hotkey-overlay";

        "Mod+T".spawn = ["ghostty"];
        "Mod+D".spawn = ["equibop"];
        "Mod+B".spawn = ["zen-twilight"];

        "Mod+O" = {
          action = "toggle-overview";
          parameters = {
            repeat = false;
          };
        };

        "Mod+Q" = {
          action = "close-window";
          parameters = {
            repeat = false;
          };
        };

        "Mod+H".action = "focus-column-left";
        "Mod+J".action = "focus-window-or-workspace-down";
        "Mod+K".action = "focus-window-or-workspace-up";
        "Mod+L".action = "focus-column-right";

        "Mod+Shift+H".action = "move-column-left";
        "Mod+Shift+J".action = "move-window-down-or-to-workspace-down";
        "Mod+Shift+K".action = "move-window-up-or-to-workspace-up";
        "Mod+Shift+L".action = "move-column-right";

        "Mod+U".action = "focus-monitor-left";
        "Mod+I".action = "focus-monitor-right";

        "Mod+Shift+U".action = "move-window-to-monitor-left";
        "Mod+Shift+I".action = "move-window-to-monitor-right";

        "Mod+WheelScrollDown" = {
          action = "focus-workspace-down";
          parameters = {
            cooldown-ms = 150;
          };
        };
        "Mod+WheelScrollUp" = {
          action = "focus-workspace-up";
          parameters = {
            cooldown-ms = 150;
          };
        };
        "Mod+Ctrl+WheelScrollDown" = {
          action = "move-column-to-workspace-down";
          parameters = {
            cooldown-ms = 150;
          };
        };
        "Mod+Ctrl+WheelScrollUp" = {
          action = "move-column-to-workspace-up";
          parameters = {
            cooldown-ms = 150;
          };
        };

        "Mod+WheelScrollRight".action = "focus-column-right";
        "Mod+WheelScrollLeft".action = "focus-column-left";
        "Mod+Ctrl+WheelScrollRight".action = "move-column-right";
        "Mod+Ctrl+WheelScrollLeft".action = "move-column-left";

        "Mod+Shift+WheelScrollDown".action = "focus-column-right";
        "Mod+Shift+WheelScrollUp".action = "focus-column-left";
        "Mod+Ctrl+Shift+WheelScrollDown".action = "move-column-right";
        "Mod+Ctrl+Shift+WheelScrollUp".action = "move-column-left";

        "Mod+1".action = "focus-workspace 1";
        "Mod+2".action = "focus-workspace 2";
        "Mod+3".action = "focus-workspace 3";
        "Mod+4".action = "focus-workspace 4";
        "Mod+5".action = "focus-workspace 5";
        "Mod+6".action = "focus-workspace 6";
        "Mod+7".action = "focus-workspace 7";
        "Mod+8".action = "focus-workspace 8";
        "Mod+9".action = "focus-workspace 9";

        "Mod+Shift+1".action = "move-window-to-workspace 1";
        "Mod+Shift+2".action = "move-window-to-workspace 2";
        "Mod+Shift+3".action = "move-window-to-workspace 3";
        "Mod+Shift+4".action = "move-window-to-workspace 4";
        "Mod+Shift+5".action = "move-window-to-workspace 5";
        "Mod+Shift+6".action = "move-window-to-workspace 6";
        "Mod+Shift+7".action = "move-window-to-workspace 7";
        "Mod+Shift+8".action = "move-window-to-workspace 8";
        "Mod+Shift+9".action = "move-window-to-workspace 9";

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

        "Print".action = "screenshot";
        "Ctrl+Print".action = "screenshot-screen";
        "Alt+Print".action = "screenshot-window";

        "Mod+Escape" = {
          action = "toggle-keyboard-shortcuts-inhibit";
          parameters = {
            allow-inhibiting = false;
          };
        };

        "Ctrl+Alt+Delete".action = "quit";

        "Mod+Shift+P".action = "power-off-monitors";
      };

      config = ''
        prefer-no-csd

        output "HDMI-A-1" {
            mode "1920x1080@239.757"
            position x=0 y=0
        }

        output "DP-3" {
            mode "1920x1080@144.001"
            position x=1920 y=0
        }

        input {
            keyboard {
                xkb {
                    options "caps:super, compose:lwin"
                }
            }

            focus-follows-mouse max-scroll-amount="50%"
        }

        gestures {
          hot-corners {
              off
          }
        }

        cursor {
            xcursor-theme "Breeze_Light"
            xcursor-size 24
        }

        layout {
            gaps 8

            focus-ring {
                off
            }

            border {
                width 2
            }
        }

        window-rule {
            geometry-corner-radius 12
            clip-to-geometry true
        }

        hotkey-overlay {
            skip-at-startup
        }

        xwayland-satellite {
            path "${lib.getExe pkgs.xwayland-satellite}"
        }
      '';
    };
  };
}
