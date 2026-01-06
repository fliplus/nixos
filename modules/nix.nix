{
  flake.nixosModules.core = {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config.allowUnfree = true;
  };
}
