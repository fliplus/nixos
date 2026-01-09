{
  flake.nixosModules.core = { inputs, ... }:

  {
    hjem = {
      extraModules = [ inputs.hjem-rum.hjemModules.hjem-rum ];

      clobberByDefault = true;
    };
  };
}
