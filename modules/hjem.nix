{ inputs, ... }:
{
  flake.nixosModules.core = {
    imports = [ inputs.hjem.nixosModules.default ];

    hjem.clobberByDefault = true;
  };
}
