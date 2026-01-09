{ pkgs, inputs, ... }: {

  imports = [ inputs.nvf.nixosModules.default ];

  # neovide like stuff
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

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
        # notes.todo-comments = {
        #   enable = true;
        #   mappings = {
        #     todoTelescope = "<leader>st"; # Space + s + t abre a lista de todos
        #   };
        # };

        autopairs.nvim-autopairs.enable = true; # Fecha () [] {}
        comments.comment-nvim.enable = true;    # Atalho 'gcc' para comentar
        binds.whichKey.enable = true;           # Menu de atalhos
        git.gitsigns.enable = true;


        visuals = {
          indent-blankline = {
            enable = true;
            setupOpts = {
              scope = { enabled = true; };
              indent = { char = "│"; };
            };
          };
          # nvim-highlight-colors.enable = true; 
          nvim-web-devicons.enable = true;     
        };



        extraPlugins = {

          toggleterm = {
            package = pkgs.vimPlugins.toggleterm-nvim;
            setup = ''
              require("toggleterm").setup({
                size = 10,
                open_mapping = [[<c-\>]],
                hide_numbers = true,
                shade_filetypes = {},
                shade_terminals = true,
                start_in_insert = true,
                persist_size = true,
                direction = 'float',
                float_opts = {
                  border = 'curved',
                  winblend = 0,
                }
              })

              -- Função customizada global para abrir na pasta do buffer atual
              local Terminal = require('toggleterm.terminal').Terminal

              function _G.abrir_term_no_dir_atual()
                -- Pega o diretório do arquivo atual ou o cwd se for vazio
                local file_dir = vim.fn.expand("%:p:h")
                if file_dir == "" then file_dir = vim.fn.getcwd() end

                local term = Terminal:new({ 
                  cmd = vim.o.shell, -- Usa o shell padrão do sistema
                  dir = file_dir,    -- O segredo está aqui
                  direction = "float",
                  on_open = function(term)
                    vim.cmd("startinsert!")
                    -- Mapeia ESC para sair do modo terminal facilmente nesta janela
                    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<C-\\><C-n><cmd>close<CR>", {noremap = true, silent = true})
                  end,
                })

                term:toggle()
              end
            '';
          };

          # BUG: not working
          tabout = {
            package = pkgs.vimPlugins.tabout-nvim;
            setup = ''
              require('tabout').setup {
                tabkey = '<Tab>', 
                backwards_tabkey = '<S-Tab>',
                act_as_tab = true,
                act_as_shift_tab = false,
                enable_backwards = true,
                completion = true,
                tabouts = {
                  {open = "'", close = "'"},
                  {open = '"', close = '"'},
                  {open = '`', close = '`'},
                  {open = '(', close = ')'},
                  {open = '[', close = ']'},
                  {open = '{', close = '}'}
                },
                ignore_beginning = true,
              }
            '';
            after = ["nvim-cmp" "nvim-treesitter"]; 
          };

          haskell-tools-nvim = {
            package = pkgs.vimPlugins.haskell-tools-nvim;
            setup = "";
          };

          aerial = {
            package = pkgs.vimPlugins.aerial-nvim;
            setup = "require('aerial').setup {}";
          };

          harpoon = {
            package = pkgs.vimPlugins.harpoon;
            setup = "require('harpoon').setup {}";
            after = ["aerial"]; 
          };
        };

        viAlias = false;
        vimAlias = true;

        diagnostics = {
          enable = true;
          config = {
            signs = true;
            update_in_insert = true;
            virtual_text = true;
          };
        };

        autocomplete.nvim-cmp = {
          enable = true;
          mappings = {
            confirm = "<Tab>"; 

            next = "<C-j>";      
            previous = "<C-k>";

            close = "<C-x>";    
          };
        };

        options = {
          cursorline = true;
          encoding = "UTF-8";
          ruler = true;
          clipboard = "unnamedplus";
          tabstop = 2;
          expandtab = true;
          shiftwidth = 2;

          # only for some guis..
          guifont = "JetBrainsMono Nerd Font:h13";
        };

        globals.mapleader = " ";
        globals.maplocalleader = " ";

        keymaps = [

          { 
            key = "<leader>tt"; 
            mode = "n"; 
            silent = true; 
            action = ":lua _G.abrir_term_no_dir_atual()<CR>"; 
            desc = "Abrir Terminal Flutuante no Dir Atual";
          }


          {  key = "<leader>w"; mode = "n"; silent = true; 
            action = ":lua local view = vim.fn.winsaveview(); vim.cmd('normal! gg=G'); vim.fn.winrestview(view); vim.cmd('wa')<CR>"; }
          { key = "<leader>i";  mode = "n"; silent = true; 
            action = ":lua local view = vim.fn.winsaveview(); vim.cmd('normal! gg=G'); vim.fn.winrestview(view)<CR>"; }
          { key = "<leader>ff"; mode = "n"; silent = true; action = ":Telescope find_files<CR>"; } 
          { key = "<leader>fg"; mode = "n"; silent = true; action = ":Telescope live_grep<CR>"; }  
          { key = "<leader>fb"; mode = "n"; silent = true; action = ":Telescope buffers<CR>"; }   
          {
            key = "<leader>ca";
            mode = "n";
            silent = true;
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

          # emacs
          { key = "<M-b>"; mode = "i"; silent = true; action = "<C-Left>"; }
          { key = "<M-f>"; mode = "i"; silent = true; action = "<C-Right>"; }
          { key = "<M-BS>"; mode = "i"; silent = true; action = "<C-w>"; } 
          { key = "<M-d>";  mode = "i"; silent = true; action = "<C-o>dw"; }
          { key = "<C-k>"; mode = "i"; silent = true; action = "<C-o>D"; }
          { key = "<C-d>"; mode = "i"; silent = true; action = "<Del>"; }
          # BUG: two different bindings to the same action
          { key = "<C-z>"; mode = "i"; silent = true; action = "<C-o>u"; }
          { key = "<C-/>"; mode = "i"; silent = true; action = "<C-o>u"; }
          {
            key = "<C-a>";
            mode = "i";
            silent = true;
            action = "<Home>";  
          } 

          {
            key = "<C-e>";
            mode = "i"; 
            silent = true;
            action = "<End>";
          }

          {
            key = "<C-f>";
            mode = "i";
            silent = true;
            action = "<Right>";
          }

          {
            key = "<C-b>";
            mode = "i";
            silent = true;
            action = "<Left>";
          }
          { key = "<M-<>"; mode = "n"; silent = true; action = "gg"; } 
          { key = "<M-<>"; mode = "i"; silent = true; action = "<C-o>gg"; } 

          { key = "<M->>"; mode = "n"; silent = true; action = "G"; } 
          { key = "<M->>"; mode = "i"; silent = true; action = "<C-o>G"; }
          { key = "<C-x>h"; mode = "n"; silent = true; action = "ggVG"; }
          { key = "<C-x>h"; mode = "i"; silent = true; action = "<Esc>ggVG"; } 
        ];

          treesitter = {
             enable = true;
             highlight.enable = true;
             indent.enable = true;
          };

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
          setupOpts = {
            defaults = {
              layout_config = { horizontal = { prompt_position = "top"; }; };
              sorting_strategy = "ascending";
              mappings = {
                i = {
                  "<C-j>" = "move_selection_next";
                  "<C-k>" = "move_selection_previous";
                  "<Esc>" = "close";
                };
                n = { "q" = "close"; };
              };
            };
          };
        };

        filetree.neo-tree = {
          enable = true;
          setupOpts = {
            window = { width = 25; };
            enable_cursor_hijack = true;
            add_blank_line_at_top = true;
            auto_clean_after_session_restore = true;
            git_status_async = true;
          };
        };

        dashboard.dashboard-nvim.enable = true;
      };
    };
  };
}
