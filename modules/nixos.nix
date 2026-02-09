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

        inputs.disko.nixosModules.disko
        inputs.disko.flakeModules.default
        { flake.diskoConfigurations = config.flake.nixosModules."disko-${host}"; }
        config.flake.nixosModules."disko-${host}"

        config.flake.nixosModules."host-${host}"

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
