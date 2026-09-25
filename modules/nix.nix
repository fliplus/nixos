{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      sops.secrets.nix_conf.owner = user;

      nix = {
        package = pkgs.lixPackageSets.latest.lix;
        settings = {
          warn-dirty = false;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
        extraOptions = ''
          !include ${config.sops.secrets.nix_conf.path}
        '';
      };

      nixpkgs.config.allowUnfree = true;
      environment.variables = {
        NIXPKGS_ALLOW_UNFREE = "1";
      };

      programs.nh = {
        enable = true;
        flake = "/home/${user}/nixos";
      };

      programs.tack = {
        enable = true;
        nixConfTokens = true;
      };

      environment.shellAliases = {
        nswitch = "nh os switch";
        nclean = "nh clean all --keep 10 --optimise";
      };
    };
}
