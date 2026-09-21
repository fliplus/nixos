{ inputs, ... }:
{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      imports = [ inputs.sops-nix.nixosModules.default ];

      environment.systemPackages = with pkgs; [
        sops
      ];

      sops = {
        defaultSopsFile = ../secrets/secrets.yaml;
        age.keyFile = "/persist/home/${user}/.config/sops/age/keys.txt";
      };

      preferences.persist.home.directories = [ ".config/sops" ];
    };
}
