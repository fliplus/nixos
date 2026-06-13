{
  flake.nixosModules.core =
    { config, pkgs, ... }:
    let
      inherit (config.preferences.system) user;
    in
    {
      environment.systemPackages = with pkgs; [
        tmux
      ];

      hjem.users.${user}.xdg.config.files."tmux/tmux.conf".text = /* tmux */ ''
        unbind C-b
        set-option -g prefix M-Space
        bind-key M-Space send-prefix

        set -g mouse on

        set -g base-index 1
        set -g pane-base-index 1
        set -g renumber-windows on

        set -g status-position top

        set -g default-terminal "$TERM"
        set -sg terminal-overrides ",*:RGB"

        set -g status-style bg=default,fg=black,bright
        set -g status-left ""
        set -g status-right "#[fg=black,bright]#S"

        set -g escape-time 0
      '';
    };
}
