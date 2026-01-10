{
  flake.nixosModules.core = { inputs, config, lib, user, ... }:

  {
    programs.hyprland.enable = true;

    hjem.users.${user}.rum.programs.hyprland = {
      enable = true;

      settings = {
        monitor = (lib.forEach config.preferences.monitors (monitor:
          "${monitor.name}, ${monitor.resolution}@${toString monitor.refreshRate}, ${monitor.position}, 1"
        ));

        general = {
          gaps_in = 5;
          gaps_out = 10;

          border_size = 2;

          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
        };

        decoration = {
          rounding = 10;
          rounding_power = 2;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };

          blur = {
            enabled = true;
            size = 3;
            passes = 1;

            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = "yes, please :)";

          bezier = [
          #  NAME,           X0,   Y0,   X1,   Y1
            "easeOutQuint,   0.23, 1,    0.32, 1"
            "easeInOutCubic, 0.65, 0.05, 0.36, 1"
            "linear,         0,    0,    1,    1"
            "almostLinear,   0.5,  0.5,  0.75, 1"
            "quick,          0.15, 0,    0.1,  1"
          ];

          animation = [
          #  NAME,          ONOFF, SPEED, CURVE,        [STYLE]
            "global,        1,     10,    default"
            "border,        1,     5.39,  easeOutQuint"
            "windows,       1,     4.79,  easeOutQuint"
            "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
            "windowsOut,    1,     1.49,  linear,       popin 87%"
            "fadeIn,        1,     1.73,  almostLinear"
            "fadeOut,       1,     1.46,  almostLinear"
            "fade,          1,     3.03,  quick"
            "layers,        1,     3.81,  easeOutQuint"
            "layersIn,      1,     4,     easeOutQuint, fade"
            "layersOut,     1,     1.5,   linear,       fade"
            "fadeLayersIn,  1,     1.79,  almostLinear"
            "fadeLayersOut, 1,     1.39,  almostLinear"
            "workspaces,    1,     1.94,  almostLinear, fade"
            "workspacesIn,  1,     1.21,  almostLinear, fade"
            "workspacesOut, 1,     1.94,  almostLinear, fade"
            "zoomFactor,    1,     7,     quick"
          ];
        };

        "$mod" = "SUPER";

        bind = [
          "$mod, C, killactive,"
          "$mod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
          "$mod, V, togglefloating,"
          "$mod, P, pseudo, "
          "$mod, J, togglesplit, "

          "$mod, F, fullscreen,"

          "$mod, Q, exec, ghostty"
          "$mod, R, exec, hyprlauncher"
          "$mod, B, exec, zen"
          "$mod, D, exec, equibop"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, S, movetoworkspace, special:magic"
        ] ++ builtins.concatLists ( builtins.genList (i:
          let
            bind = toString (i + 1 - ((i + 1) / 10) * 10);
            workspace = toString (i + 1);
          in [
            "$mod, ${bind}, workspace, ${workspace}"
            "$mod SHIFT, ${bind}, movetoworkspace, ${workspace}"
          ]
        ) 10);

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        workspace = lib.optionals (lib.length config.preferences.monitors > 1) (builtins.concatMap (monitor:
          builtins.map (workspace:"${toString workspace}, monitor:${monitor.name}") monitor.workspaces
        ) config.preferences.monitors);
      };
    };
  };
}
