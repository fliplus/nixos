{
  flake.nixosModules.core =
    {
      inputs,
      config,
      lib,
      pkgs,
      ...
    }:
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

        kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

        kernelParams = lib.forEach config.preferences.monitors (
          monitor:
          "video=${monitor.name}:${monitor.resolution}@${
            toString (builtins.floor (monitor.refreshRate + 0.5))
          }"
        );

        zfs.package = pkgs.zfs_unstable;

        plymouth = {
          enable = true;
          theme = "mac-style";
          themePackages = [ inputs.mac-style-plymouth.packages.${pkgs.stdenv.hostPlatform.system}.default ];
        };
      };
    };
}
