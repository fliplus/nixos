{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      environment.systemPackages = with pkgs; [
        herdr
      ];

      hjem.users.${user}.xdg.config.files."herdr/config.toml" = {
        generator = (pkgs.formats.toml { }).generate "config.toml";

        value = {
          onboarding = false;

          theme.name = "terminal";

          keys.prefix = "alt+space";

          ui = {
            sidebar_start_collapsed = true;
            sidebar_collapsed_mode = "hidden";
            prompt_new_tab_name = false;
            pane_borders = false;
            pane_gaps = false;
            hide_tab_bar_when_single_tab = true;
          };
        };
      };
    };
}
