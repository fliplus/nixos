{
  flake.nixosModules.core = {inputs, ...}: {
    imports = [inputs.nvf.nixosModules.default];

    programs.nvf = {
      enable = true;

      settings.vim = {
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };

        options = {
          shiftwidth = 2;
        };

        lsp.enable = true;

        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;

        languages = {
          enableTreesitter = true;

          nix = {
            enable = true;
            format.type = ["nixfmt"];
          };
        };

        statusline.lualine.enable = true;
        binds.whichKey.enable = true;
      };
    };
  };
}
