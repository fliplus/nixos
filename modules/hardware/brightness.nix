{
  flake.nixosModules.laptop = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      brightnessctl
    ];

    preferences.binds = {
      "XF86MonBrightnessUp".command = "brightnessctl --class=backlight set +5%";
      "XF86MonBrightnessDown".command = "brightnessctl --class=backlight set 5%-";
    };
  };
}
