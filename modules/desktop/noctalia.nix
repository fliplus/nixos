{
  flake.nixosModules.core = {
    inputs,
    pkgs,
    user,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
    ];

    hjem.users.${user} = {
      rum.desktops.niri = {
        spawn-at-startup = [
          ["noctalia-shell"]
        ];

        binds = {
          "Mod+S".spawn = ["noctalia-shell" "ipc" "call" "launcher" "toggle"];
        };

        config = ''include optional=true "/home/flip/.config/niri/noctalia.kdl"'';
      };

      xdg.config.files."ghostty/config" = {
        value.theme = "noctalia";
      };
    };

    preferences.persist.home.directories = [
      ".config/noctalia"
      ".cache/noctalia"

      ".config/niri"
      ".config/ghostty"
    ];
  };
}
