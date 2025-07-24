{ config, lib, pkgs, ... }: {

  programs.neovim = { 
    plugins = with pkgs.vimPlugins; [
      {
        plugin = neo-tree-nvim;
        config = ''
          lua << EOF
          require("neo-tree").setup({
            close_if_last_window = true,   
            popup_border_style = "NC", 
            enable_git_status = true,
            enable_diagnostics = true,
            open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, 
            open_files_using_relative_paths = false,
            sort_case_insensitive = false,
            sort_function = nil,
            filesystem = {
              follow_current_file = true,  
              hijack_netrw_behavior = "open_default"  
            }
          })

          EOF
        '';
    }
  ];
  
  extraLuaConfig = ''
    vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
    vim.keymap.set('n', '<leader>n', ':Neotree filesystem close left<CR>', {})
  '';

  };
}




