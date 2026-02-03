{
  flake.nixosModules.core = {
    pkgs,
    user,
    ...
  }: {
    nix = {
      package = pkgs.lixPackageSets.git.lix;
      settings = {
        warn-dirty = false;
        experimental-features = ["nix-command" "flakes"];
      };
    };

    nixpkgs.config.allowUnfree = true;

    programs.nh = {
      enable = true;
      flake = "/home/${user}/nixos";
    };
  };
}
