{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      programs.git = {
        enable = true;

        config = {
          user = {
            name = "Filipe Abreu";
            email = "134308239+fliplus@users.noreply.github.com";
          };
        };
      };

      environment.systemPackages = with pkgs; [
        lazygit
      ];

      preferences.persist.home.directories = [ ".config/lazygit" ];
    };
}
