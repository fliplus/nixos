{
  flake.nixosModules.core = {
    inputs,
    pkgs,
    ...
  }: {
    programs.vscode = {
      enable = true;

      extensions = with pkgs.vscode-extensions;
        [
          vscodevim.vim
          bbenoist.nix
          jdinhlife.gruvbox
          tamasfe.even-better-toml
        ]
        ++ [
          inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.open-vsx.federicocarboni.scarpet-ls
        ];
    };

    preferences.persist.home.directories = [
      ".vscode"
      ".config/Code"
    ];
  };
}
