{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        equibop
      ];

      preferences.binds = {
        "Mod+D".command = "equibop";
        "Mod+M".command = "equibop --toggle-mic";
        "Mod+Shift+M".command = "equibop --toggle-deafen";
      };

      preferences.persist.home.directories = [ ".config/equibop" ];
    };
}
