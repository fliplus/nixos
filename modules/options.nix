{
  flake.nixosModules.core = { lib, ... }:
  let
    inherit (lib) any assertMsg hasPrefix mkOption;
    inherit (lib.types) listOf str;

    assertNoHomeDirs =
      paths:
      assert (assertMsg (!any (hasPrefix "/home") paths) "/home used in a root persist!");
      paths;
  in
  {
    options.preferences = {
      persist = {
        root = {
          directories = mkOption {
            type = listOf str;
            default = [ ];
            apply = assertNoHomeDirs;
            description = "Directories to persist in root filesystem";
          };
          files = mkOption {
            type = listOf str;
            default = [ ];
            apply = assertNoHomeDirs;
            description = "Files to persist in root filesystem";
          };

          cache = {
            directories = mkOption {
              type = listOf str;
              default = [ ];
              apply = assertNoHomeDirs;
              description = "Directories to persist, but not to snapshot";
            };
            files = mkOption {
              type = listOf str;
              default = [ ];
              apply = assertNoHomeDirs;
              description = "Files to persist, but not to snapshot";
            };
          };
        };

        home = {
          directories = mkOption {
            type = listOf str;
            default = [ ];
            description = "Directories to persist in home directory";
          };
          files = mkOption {
            type = listOf str;
            default = [ ];
            description = "Files to persist in home directory";
          };

          cache = {
            directories = mkOption {
              type = listOf str;
              default = [ ];
              description = "Directories to persist, but not to snapshot";
            };
            files = mkOption {
              type = listOf str;
              default = [ ];
              description = "Files to persist, but not to snapshot";
            };
          };
        };
      };
    };
  };
}
