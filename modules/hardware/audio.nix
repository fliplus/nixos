{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
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
        playerctl
      ];

      preferences.binds = {
        "XF86AudioRaiseVolume".command = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume".command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute".command = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute".command = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86AudioPlay".command = "playerctl play-pause";
        "XF86AudioPause".command = "playerctl play-pause";
        "XF86AudioNext".command = "playerctl next";
        "XF86AudioPrev".command = "playerctl previous";
      };

      preferences.persist.home.directories = [ ".local/state/wireplumber" ];
    };
}
