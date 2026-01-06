{ config, inputs, ... }:
let
  user = "flip";
  mkNixos = host: inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs host user; };
    modules = [
      config.flake.nixosModules."host-${host}"

      inputs.disko.nixosModules.disko
      config.flake.diskoModules."disko-${host}"
      
      inputs.impermanence.nixosModules.impermanence
      config.flake.nixosModules.core
    ];
  };
in
{
  flake.nixosConfigurations = {
    framework = mkNixos "framework";
  };
}
