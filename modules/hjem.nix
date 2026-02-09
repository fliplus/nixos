{ inputs, ... }:
{
  flake.nixosModules.core = {
    imports = [ inputs.hjem.nixosModules.hjem ];

    hjem = {
      extraModules = [ inputs.hjem-rum.hjemModules.hjem-rum ];

      clobberByDefault = true;
    };
  };
}
