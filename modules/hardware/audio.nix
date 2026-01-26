{
  flake.nixosModules.core = {pkgs, ...}: {
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pulsemixer
    ];

    preferences.persist.home.directories = [".local/state/wireplumber"];
  };
}
