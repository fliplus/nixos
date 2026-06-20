{ inputs, ... }:
{
  flake.nixosModules.core = {
    imports = [ inputs.nvf.nixosModules.default ];

    environment.variables = {
      EDITOR = "nvim";
    };

    programs.nvf = {
      enable = true;

      settings.vim = {
        theme = {
          enable = true;
          name = "rose-pine";
          style = "main";
        };

        options = {
          expandtab = true;
          shiftwidth = 2;

          scrolloff = 8;

          colorcolumn = "120";

          wrap = false;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
        };

        languages = {
          enableTreesitter = true;
          enableFormat = true;

          nix = {
            enable = true;
            lsp.servers = [
              "nil"
              "nixd"
            ];
            format.type = [ "nixfmt" ];
          };

          ruby = {
            enable = true;
            lsp.servers = [ "ruby-lsp" ];
          };
          html.enable = true;
          typescript.enable = true;

          rust.enable = true;

          kotlin = {
            enable = true;
            lsp.enable = false;
          };

          assembly.enable = true;

          qml = {
            enable = true;
            lsp.enable = false;
          };
        };

        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;

        git.enable = true;

        telescope.enable = true;

        utility = {
          yazi-nvim.enable = true;
          motion.flash-nvim.enable = true;
        };

        filetree.neo-tree = {
          enable = true;
          setupOpts = {
            window.position = "right";
          };
        };

        autopairs.nvim-autopairs.enable = true;

        statusline.lualine.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        keymaps = [
          {
            key = "<leader>/";
            mode = "n";
            action = ":Cheatsheet<cr>";
          }
          {
            key = "<leader>?";
            mode = "n";
            action = ":WhichKey<cr>";
          }
          {
            key = "<leader>e";
            mode = "n";
            action = ":Neotree toggle<cr>";
          }
        ];

        luaConfigPost = /* lua */ ''
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        '';
      };
    };
  };
}
