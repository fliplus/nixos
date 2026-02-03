{
  flake.nixosModules.core = {lib, ...}: let
    inherit (lib) any assertMsg hasPrefix mkOption;
    inherit (lib.types) int listOf nonEmptyListOf str submodule;

    assertNoHomeDirs = paths:
      assert (assertMsg (!any (hasPrefix "/home") paths) "/home used in a root persist!"); paths;
  in {
    options.preferences = {
      persist = {
        root = {
          directories = mkOption {
            description = "Directories to persist in root filesystem";
            type = listOf str;
            apply = assertNoHomeDirs;
            default = [];
          };
          files = mkOption {
            description = "Files to persist in root filesystem";
            type = listOf str;
            apply = assertNoHomeDirs;
            default = [];
          };

          cache = {
            directories = mkOption {
              description = "Directories to persist, but not to snapshot";
              type = listOf str;
              apply = assertNoHomeDirs;
              default = [];
            };
            files = mkOption {
              description = "Files to persist, but not to snapshot";
              type = listOf str;
              apply = assertNoHomeDirs;
              default = [];
            };
          };
        };

        home = {
          directories = mkOption {
            description = "Directories to persist in home directory";
            type = listOf str;
            default = [];
          };
          files = mkOption {
            description = "Files to persist in home directory";
            type = listOf str;
            default = [];
          };

          cache = {
            directories = mkOption {
              description = "Directories to persist, but not to snapshot";
              type = listOf str;
              default = [];
            };
            files = mkOption {
              description = "Files to persist, but not to snapshot";
              type = listOf str;
              default = [];
            };
          };
        };
      };

      monitors = mkOption {
        description = "Configuration for monitors";
        type = nonEmptyListOf (submodule {
          options = {
            name = mkOption {
              description = "Name of the display";
              type = str;
            };
            resolution = mkOption {
              description = "Resolution of the display";
              type = str;
            };
            refreshRate = mkOption {
              description = "Refresh rate of the display";
              type = int;
            };
            position = mkOption {
              description = "Position of the display";
              type = str;
            };
            workspaces = mkOption {
              description = "List of workspace numbers";
              type = listOf int;
            };
          };
        });
        default = [];
      };

      binds = mkOption {
        description = "Configuration for keybinds";
        type = nonEmptyListOf (submodule {
          options = {
            hotkey = mkOption {
              description = "Hotkey";
              type = listOf str;
            };
            command = mkOption {
              description = "Command to execute";
              type = listOf str;
            };
          };
        });
        default = [];
      };
      auto-start = mkOption {
        description = "Programs to start automatically";
        type = listOf (listOf str);
        default = [];
      };
    };
  };
}
