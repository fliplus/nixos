{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      virtualisation = {
        libvirtd = {
          enable = true;
          qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
        };

        spiceUSBRedirection.enable = true;

        docker.enable = true;
      };

      programs.virt-manager.enable = true;

      environment.systemPackages = with pkgs; [
        winboat
      ];

      users.users.${user}.extraGroups = [
        "libvirtd"
        "docker"
      ];

      preferences.persist = {
        root.directories = [
          "/var/lib/libvirt"
          "/var/lib/docker"
        ];
        home.directories = [
          ".winboat"
          "winboat"
          ".config/winboat"
        ];
      };
    };
}
