{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gradia
        wl-clipboard
      ];

      preferences.binds = [
        {
          hotkey = [
            "Mod"
            "Shift"
            "E"
          ];
          command = [
            "sh"
            "-c"
            "wl-paste | gradia"
          ];
        }
      ];
    };
}
