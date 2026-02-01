{
  flake.nixosModules.core = {inputs, ...}: {
    imports = [inputs.nvf.nixosModules.default];

    environment.variables = {
      EDITOR = "nvim";
    };

    programs.nvf = {
      enable = true;

      settings.vim = {
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };

        options = {
          expandtab = true;
          shiftwidth = 2;

          scrolloff = 8;

          colorcolumn = "120";
        };

        lsp = {
          enable = true;
          formatOnSave = true;
        };

        languages = {
          enableTreesitter = true;
          enableFormat = true;

          nix.enable = true;
          ruby.enable = true;
        };

        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;

        telescope.enable = true;

        utility = {
          yazi-nvim.enable = true;
          motion.flash-nvim.enable = true;
        };

        autopairs.nvim-autopairs.enable = true;

        statusline.lualine.enable = true;

        binds.whichKey.enable = true;

        keymaps = [
          {
            key = "<leader>?";
            mode = "n";
            action = '':lua require("which-key").show()<cr>'';
          }
        ];
      };
    };
  };
}
