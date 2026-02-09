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
      specialArgs = {
        inherit
          inputs
          host
          user
          isLaptop
          ;
      };
      modules = [
        config.flake.nixosModules."host-${host}"

        inputs.disko.nixosModules.disko
        config.flake.nixosModules."disko-${host}"

        inputs.impermanence.nixosModules.impermanence

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
