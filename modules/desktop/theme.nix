{
  flake.nixosModules.core = {
    pkgs,
    user,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      kdePackages.breeze
      adw-gtk3
      papirus-icon-theme
    ];

    environment.sessionVariables = {
      XCURSOR_THEME = "Breeze_Light";
    };

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
  };
}
