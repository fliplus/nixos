{
  flake.nixosModules.wireshark =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      programs.wireshark = {
        enable = true;
        package = pkgs.wireshark;
      };
      users.users.${user}.extraGroups = [ "wireshark" ];
    };
}
