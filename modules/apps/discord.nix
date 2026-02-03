{
  flake.nixosModules.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      equibop
    ];

    preferences.binds = [
      {
        hotkey = ["Mod" "D"];
        command = ["equibop"];
      }
      {
        hotkey = ["Mod" "M"];
        command = ["equibop" "--toggle-mic"];
      }
      {
        hotkey = ["Mod" "Shift" "M"];
        command = ["equibop" "--toggle-deafen"];
      }
    ];

    preferences.persist.home.directories = [
      ".config/equibop"
    ];
  };
}
