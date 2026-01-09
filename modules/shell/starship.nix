{
  flake.nixosModules.core = {
    programs.starship = {
      enable = true;
      transientPrompt.enable = true;

      settings = {
        add_newline = false;
      };
    };
  };
}
