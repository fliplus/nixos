{
  flake.nixosModules.core = {
    inputs,
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      inputs.zen-browser.packages.${stdenv.hostPlatform.system}.twilight
    ];

    environment.etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
          zen
        '';
        mode = "0755";
      };
    };

    preferences.binds = [
      {
        hotkey = ["Mod" "B"];
        command = ["zen-twilight"];
      }
    ];

    preferences.persist.home.directories = [
      ".zen"
    ];
  };
}
