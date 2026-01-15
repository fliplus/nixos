{
  flake.nixosModules.core = { inputs, pkgs, ... }:

  {
    programs.vscode = {
      enable = true;

      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        bbenoist.nix
      ];
    };

    preferences.persist.home.directories = [
      ".vscode"
      ".config/Code"
    ];
  };
}
