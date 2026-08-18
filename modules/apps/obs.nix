{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        (pkgs.wrapOBS {
          plugins = with pkgs.obs-studio-plugins; [
            obs-pipewire-audio-capture
          ];
        })
      ];

      preferences.persist.home.directories = [ ".config/obs-studio" ];
    };
}
