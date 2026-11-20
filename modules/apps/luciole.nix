{ inputs, ... }:
{
  flake.nixosModules.core = {
    imports = [ inputs.luciole.nixosModules.default ];

    programs.luciole.enable = true;
  };
}
