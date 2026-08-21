{ lib, ... }:
{
  flake.nixosModules.core =
    let
      assertNoHomeDirs =
        paths:
        assert (lib.assertMsg (!lib.any (lib.hasPrefix "/home") paths) "/home used in a root persist!");
        paths;
    in
    {
      options.preferences = {
        system = lib.mkOption {
          type = lib.types.attrsOf lib.types.unspecified;
          default = { };
        };

        persist = {
          root = {
            directories = lib.mkOption {
              description = "Directories to persist in root filesystem";
              type = lib.types.listOf lib.types.str;
              apply = assertNoHomeDirs;
              default = [ ];
            };
            files = lib.mkOption {
              description = "Files to persist in root filesystem";
              type = lib.types.listOf lib.types.str;
              apply = assertNoHomeDirs;
              default = [ ];
            };

            cache = {
              directories = lib.mkOption {
                description = "Directories to persist, but not to snapshot";
                type = lib.types.listOf lib.types.str;
                apply = assertNoHomeDirs;
                default = [ ];
              };
              files = lib.mkOption {
                description = "Files to persist, but not to snapshot";
                type = lib.types.listOf lib.types.str;
                apply = assertNoHomeDirs;
                default = [ ];
              };
            };
          };

          home = {
            directories = lib.mkOption {
              description = "Directories to persist in home directory";
              type = lib.types.listOf lib.types.str;
              default = [ ];
            };
            files = lib.mkOption {
              description = "Files to persist in home directory";
              type = lib.types.listOf lib.types.str;
              default = [ ];
            };

            cache = {
              directories = lib.mkOption {
                description = "Directories to persist, but not to snapshot";
                type = lib.types.listOf lib.types.str;
                default = [ ];
              };
              files = lib.mkOption {
                description = "Files to persist, but not to snapshot";
                type = lib.types.listOf lib.types.str;
                default = [ ];
              };
            };
          };
        };

        monitors = lib.mkOption {
          description = "Configuration for monitors";
          type = lib.types.nonEmptyListOf (
            lib.types.submodule {
              options = {
                name = lib.mkOption {
                  description = "Name of the display";
                  type = lib.types.str;
                };
                resolution = lib.mkOption {
                  description = "Resolution of the display";
                  type = lib.types.str;
                };
                refreshRate = lib.mkOption {
                  description = "Refresh rate of the display";
                  type = lib.types.float;
                };
                x = lib.mkOption {
                  description = "X position of the display";
                  type = lib.types.int;
                };
                y = lib.mkOption {
                  description = "Y position of the display";
                  type = lib.types.int;
                };
                workspaces = lib.mkOption {
                  description = "Workspaces assigned to the display";
                  type = lib.types.listOf lib.types.int;
                };
              };
            }
          );
          default = [ ];
        };

        binds = lib.mkOption {
          description = "Configuration for keybinds";
          type = lib.types.attrsOf (
            lib.types.submodule {
              options = {
                command = lib.mkOption {
                  description = "Command to execute";
                  type = lib.types.str;
                  apply = lib.splitString " ";
                };
                repeat = lib.mkOption {
                  description = "Whether the command should repeat while the hotkey is held";
                  type = lib.types.bool;
                  default = true;
                };
              };
            }
          );
          default = { };
        };
        auto-start = lib.mkOption {
          description = "Programs to start automatically";
          type = lib.types.listOf lib.types.str;
          apply = map (lib.splitString " ");
          default = [ ];
        };
      };
    };
}
