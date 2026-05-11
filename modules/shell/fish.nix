{
  flake.nixosModules.core = {
    programs.fish = {
      enable = true;

      shellInit = ''
        set fish_greeting

        function y
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          command yazi $argv --cwd-file="$tmp"
          if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
          end
          command rm -f -- "$tmp"
        end
      '';

      interactiveShellInit = ''
        function yazi_cd
          y
          commandline -f repaint
        end
        bind \ey yazi_cd
      '';
    };

    documentation.man.cache.enable = false;

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      flags = [ "--cmd cd" ];
    };

    preferences.persist.home.files = [
      ".local/share/fish/fish_history"
    ];

    preferences.persist.home.directories = [
      ".local/share/zoxide"
    ];
  };
}
