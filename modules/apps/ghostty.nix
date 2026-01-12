{
  flake.nixosModules.core = { lib, pkgs, user, ... }:

  {
    environment.systemPackages = with pkgs; [
      ghostty
    ];

    hjem.users.${user}.xdg.config.files."ghostty/config" = {
      generator = lib.generators.toKeyValue { };

      value = {
        theme = "Gruvbox Dark";
        background-opacity = 0.85;
        window-padding-x = 8;
        window-padding-y = 8;
        confirm-close-surface = false;
      };
    };
  };
}
