{ config, lib, pkgs, ... }: {

  programs.neovim.plugins = with pkgs.vimPlugins; [ 
    {
      plugin = neo-tree-nvim;
      config = ''
      lua << EOF
      require("neo-tree").setup({
        close_if_last_window = true,   
        filesystem = {
          follow_current_file = true,  
          hijack_netrw_behavior = "open_default"  
        }
      })

      vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
      vim.keymap.set('n', '<leader>n', ':Neotree filesystem close left<CR>', {})

      EOF
      '';
    }

  ];
}




