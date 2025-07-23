{ config, lib, pkgs, ... }: {

  programs.neovim.plugins = with pkgs.vimPlugins; [ 
    {
      plugin = telescope-nvim;
      config = ''
        lua << EOF
        local builtin = require("telescope.builtin")
        vim.keymap.set('n', '<C-p>', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

        require("telescope").setup({
          extensions = {
            ["ui-select"] = require("telescope.themes").get_dropdown({})
          }
        })
        require("telescope").load_extension("ui-select")

        EOF
      '';
    }

    telescope-ui-select-nvim
  ];

  #TODO: nix lsp when?
  home.packages = with pkgs; [
    ripgrep # dependency 
  ];

}




