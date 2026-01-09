{
  flake.nixosModules.core = { inputs, pkgs, host, ... }:

  {
    boot.loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
    };

    networking.hostName = host;

    networking.networkmanager = {
      enable = true;
      insertNameservers = [ "1.1.1.1" ];
    };

    time.timeZone = "Europe/Lisbon";

    i18n.defaultLocale = "en_US.UTF-8";

    services.displayManager.gdm.enable = true;
    programs.hyprland.enable = true;

    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      _1password-gui
      equibop
      ghostty
      hyprlauncher
      neovim
      pulsemixer
      (prismlauncher.override {
        jdks = [ javaPackages.compiler.temurin-bin.jdk-25 ];
      })
      inputs.zen-browser.packages.${system}.twilight
    ];

    programs.steam.enable = true;

    programs.git = {
      enable = true;

      config = {
        user = {
          name = "Filipe Abreu";
          email = "134308239+fliplus@users.noreply.github.com";
        };
      };
    };

    services.openssh.enable = true;
    programs.ssh.extraConfig = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';

    preferences.persist.root = {
      directories = [
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/etc/NetworkManager/system-connections"
      ];

      files = [
        "/etc/machine-id"
      ];
    };

    preferences.persist.home.directories = [
      ".config/1Password"
      ".config/equibop"
      ".config/hypr"
      ".local/share/PrismLauncher"
      ".local/share/Steam"
      ".zen"
      "nixos"
    ];

    preferences.persist.home.cache.directories = [
      ".local/state/wireplumber"
    ];

    system.stateVersion = "25.11";
  };
}
