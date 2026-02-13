{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      virtualisation.libvirtd = {
        enable = true;
        qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
      };

      programs.virt-manager.enable = true;

      users.users.${user}.extraGroups = [ "libvirtd" ];

      preferences.persist.root.directories = [ "/var/lib/libvirt/" ];
    };
}
