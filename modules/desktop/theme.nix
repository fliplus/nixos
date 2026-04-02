{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      environment.systemPackages = with pkgs; [
        kdePackages.breeze
        adw-gtk3
        papirus-icon-theme
      ];

      environment.sessionVariables = {
        XCURSOR_THEME = "Breeze_Light";
        XCURSOR_SIZE = 24;
      };

      hjem.users.${user}.files.".icons/default".source =
        "${pkgs.kdePackages.breeze}/share/icons/Breeze_Light";

      programs.dconf = {
        enable = true;

        profiles.user.databases = [
          {
            settings = {
              "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
                cursor-theme = "Breeze_Light";
                gtk-theme = "adw-gtk3-dark";
                icon-theme = "Papirus-Dark";
              };
            };
          }
        ];
      };

      qt = {
        enable = true;
        platformTheme = "qt5ct";
      };

      preferences.persist.home.directories = [
        ".config/qt5ct"
        ".config/qt6ct"
      ];
    };
}
