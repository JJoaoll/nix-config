{ pkgs, inputs, ... }: {

  imports = [ inputs.nvf.nixosModules.default ];

  environment.systemPackages = with pkgs; [
    xclip
    fzf
    ripgrep
  ];

  programs.nvf = { 
    enable = true;

    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        lsp = {
          enable = true;
        };

        diagnostics = {
          enable = true;
          config = {
            signs = true;
            # update_in_insert = true;
            # virtual_lines = true;
            virtual_text = true;

          };
          nvim-lint.lint_after_save = true;

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
