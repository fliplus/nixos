{
  flake.nixosModules.core = { inputs, pkgs, ... }:
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    imports = [ inputs.spicetify-nix.nixosModules.spicetify ];

    programs.spicetify = {
      enable = true;

      enabledCustomApps = with spicePkgs.apps; [
        marketplace
      ];
    };

    preferences.persist.home.directories = [
      ".config/spotify"
      ".cache/spotify"
    ];
  };
}
