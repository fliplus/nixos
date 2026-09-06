{ inputs, lib, ... }:
{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    {
      boot = {
        loader = {
          efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
          };
          grub = {
            enable = true;
            device = "nodev";
            efiSupport = true;
            useOSProber = true;

            theme = pkgs.fetchFromGitHub {
              owner = "Jacksaur";
              repo = "CRT-Amber-GRUB-Theme";
              rev = "master";
              hash = "sha256-ATm0b9e3Qcv42E5CQYB7Umc8NpWw90QdjJmArOKbmaY=";
            };
          };
          timeout = null;
        };

        supportedFilesystems = [ "ntfs" ];

        kernelPackages = pkgs.linuxPackages_cachyos;

        consoleLogLevel = 3;
        initrd.verbose = false;

        kernelParams = [
          "quiet"
          "rd.udev.log_level=3"
          "rd.systemd.show_status=auto"
        ]
        ++ lib.forEach config.preferences.monitors (
          monitor:
          "video=${monitor.name}:${monitor.resolution}@${
            toString (builtins.floor (monitor.refreshRate + 0.5))
          }"
        );

        zfs.package = pkgs.zfs_cachyos;

        plymouth = {
          enable = true;
          theme = "mac-style";
          themePackages = [ inputs.mac-style-plymouth.packages.${pkgs.stdenv.hostPlatform.system}.default ];
        };
      };
    };
}
