{
  inputs,
  config,
  lib,
  ...
}:
let
  mkNixos =
    host:
    {
      user ? "flip",
      isLaptop ? false,
    }:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        {
          config.preferences.system = {
            inherit host user isLaptop;
          };
        }

        config.flake.nixosModules."host-${host}"

        inputs.disko.nixosModules.disko
        config.flake.nixosModules."disko-${host}"

        config.flake.nixosModules.core
      ]
      ++ lib.optionals isLaptop [ config.flake.nixosModules.laptop ];
    };
in
{
  flake.nixosConfigurations = {
    onemore = mkNixos "onemore" { };
    framework = mkNixos "framework" { isLaptop = true; };
  };
}
