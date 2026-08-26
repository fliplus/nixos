{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      nix = {
        package = pkgs.lixPackageSets.latest.lix;
        settings = {
          warn-dirty = false;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
      };

      nixpkgs.config.allowUnfree = true;
      environment.variables = {
        NIXPKGS_ALLOW_UNFREE = "1";
      };

      programs.nh = {
        enable = true;
        flake = "/home/${user}/nixos";
      };

      environment.shellAliases = {
        nswitch = "nh os switch";
        nclean = "nh clean all --keep 10 --optimise";
      };
    };
}
