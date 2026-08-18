{
  flake.nixosModules.quartus =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      environment.systemPackages = with pkgs; [
        quartus-prime-lite
      ];

      services.udev.packages = with pkgs; [
        usb-blaster-udev-rules
      ];

      environment.sessionVariables = {
        SALT_LICENSE_SERVER = "/home/${user}/.altera.quartus/questa_lic.dat";
      };

      preferences.persist.home.directories = [ ".altera.quartus" ];
    };
}
