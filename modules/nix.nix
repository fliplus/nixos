{
  flake.nixosModules.core = { user, ... }:

  {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config.allowUnfree = true;

    programs.nh = {
      enable = true;
      flake = "/home/${user}/nixos";
    };
  };
}
