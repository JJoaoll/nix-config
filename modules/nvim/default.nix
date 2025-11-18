{ pkgs, inputs, ... }: {

  imports = [ inputs.nvf.nixosModules.default ];

  environment.systemPackages = with pkgs; [
    vimPlugins.haskell-tools-nvim
    xclip
    fzf
    ripgrep
  ];

  programs.nvf = { 
    enable = true;

    settings = {
      vim = {
        extraPlugins = {

          haskell-tools-nvim = {
            package = pkgs.vimPlugins.haskell-tools-nvim;
              setup = 
              "
              -- ~/.config/nvim/after/ftplugin/haskell.lua
              local ht = require('haskell-tools')
              local bufnr = vim.api.nvim_get_current_buf()
              local opts = { noremap = true, silent = true, buffer = bufnr, }
              -- haskell-language-server relies heavily on codeLenses,
              -- so auto-refresh (see advanced configuration) is enabled by default
              vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)
              -- Hoogle search for the type signature of the definition under the cursor
              vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
              -- Evaluate all code snippets
              vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
              -- Toggle a GHCi repl for the current package
              vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
              -- Toggle a GHCi repl for the current buffer
              vim.keymap.set('n', '<leader>rf', function()
                ht.repl.toggle(vim.api.nvim_buf_get_name(0))
              end, opts)
              vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)
              ";

          };

          # vimacs = {
          #   package = pkgs.vimPlugins.vimacs;
          #   setup = "require('vimacs').setup {}";
          # };

          aerial = {
            package = pkgs.vimPlugins.aerial-nvim;
            setup = "require('aerial').setup {}";
          };

          harpoon = {
            package = pkgs.vimPlugins.harpoon;
            setup = "require('harpoon').setup {}";
            after = ["aerial"]; # place harpoon configuration after aerial
          };



        };

        # extraPlugins = with pkgs.vimPlugins; {
        #
        #
        # };

        # harpoon = {
        #   package = harpoon;
        #   setup = "require('harpoon').setup {}";
        #   after = ["aerial"]; # place harpoon configuration after aerial
        # };


        # };   


        viAlias = false;
        vimAlias = true;
        lsp = {
          enable = true;
        };

        diagnostics = {
          enable = true;
          config = {
            signs = true;
            update_in_insert = true;
            # virtual_lines = true;
            virtual_text = true;

          };
          # nvim-lint.lint_after_save = true;

        };

        options = {
          cursorline = true;
          encoding = "UTF-8";
          ruler = true;
          clipboard = "unnamedplus";
          tabstop = 2;
          shiftwidth = 2;
        };

        globals.mapleader = " ";
        globals.maplocalleader = " ";

        keymaps = [
          {
            key = "<leader>ca";
            mode = "n";
            silent = true;
            # action = ":Telescope code_actions<CR>";
            # action = ":lua require('telescope.builtin').code_actions()<CR>";
            # action = ":lua require('telescope.builtin').code_actions()<CR>";
            # action = ":lua vim.lsp.buf.code_action()<CR>";
            # action = ":Telescope code_actions<CR>";
            action = ":lua vim.lsp.buf.code_action()<CR>";
          }

          {
            key = "<C-n>";
            mode = "n";
            silent = true;
            action = ":Neotree filesystem reveal left<CR>";
          }

          {
            key = "<leader>n";
            mode = "n";
            silent = true;
            action = ":Neotree filesystem close left<CR>";
          }

          {
            key = "<leader>d";
            mode = "n";
            silent = true;
            action = ":lua vim.diagnostic.open_float()<CR>";
          }

          {
            key = "<C-a>";
            mode = "i";
            silent = true;
            action = "<ESC> :normal! I <ENTER>";  
          } 

          {
            key = "<C-e>";
            mode = "i"; 
            silent = true;
            action = "<ESC> :normal! A <ENTER>";
          }


        ];

        languages = {
          enableDAP = true;
          enableExtraDiagnostics = true;
          enableFormat = true;
          enableTreesitter = true;

          assembly.enable = true;
          clang.enable = true;
          rust.enable = true;
          gleam.enable = true;
          elixir.enable = true;
          haskell.enable = true;
          html.enable = true;
          # css.enable = true;
          nix.enable = true;
        };

        statusline.lualine = {
          enable = true;
          theme = "gruvbox_dark";
        };

        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
          transparent = true;

        };

        telescope = {
          enable = true;

          # extensions = [
          #   {
          #     name = "code_actions"; 
          #     # packages = [ pkgs.vimPlugins.telescope-code-actions-nvim ];
          #     packages = [ pkgs.vimPlugins.telescope-code-actions ];
          #   }
          # ];

        };

        filetree.neo-tree = {
          enable = true;
          setupOpts = {

            window = {
              width = 25;

              #other things..
            };

            enable_cursor_hijack = true;
            add_blank_line_at_top = true;
            auto_clean_after_session_restore = true;
            git_status_async = true;
            # example
            # default_source = "last";
          };
        };

        #TODO: configure
        dashboard.dashboard-nvim.enable = true;


        # #TODO: neovim version or roll back
        # dashboard.alpha = {
        #   enable = true;
        # };





      };


    };
  };



}
