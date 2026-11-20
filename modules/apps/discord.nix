{
  flake.nixosModules.core =
    { pkgs, ... }:
    let
      # equibop package definition from nixpkgs master, built against our
      # own pkgs so electron etc. come from the binary cache
      nixpkgs-master = builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/9736c9da7725b5c7d351ad522ff644c9c5b2157b.tar.gz";
        sha256 = "0bsfcv6c1dsbv0p3x198xd9qvv6s8sga7aa7bxvjdinq0h7h210b";
      };
      equibop = pkgs.callPackage "${nixpkgs-master}/pkgs/by-name/eq/equibop/package.nix" { };
    in
    {
      environment.systemPackages = [
        equibop
      ];

      preferences.binds = {
        "Mod+D".command = "equibop";
        "Mod+M".command = "equibop --toggle-mic";
        "Mod+Shift+M".command = "equibop --toggle-deafen";
      };

      preferences.persist.home.directories = [ ".config/equibop" ];
    };
}
