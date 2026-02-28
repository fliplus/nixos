{
  flake.nixosModules.core =
    { config, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      nix = {
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
    };
}
