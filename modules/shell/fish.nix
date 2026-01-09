{
  flake.nixosModules.core = {
    programs.fish = {
      enable = true;

      shellInit = ''
        set fish_greeting
      '';
    };
  };
}
