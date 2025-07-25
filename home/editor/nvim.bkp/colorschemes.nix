{ config, lib, pkgs, ... }: 

let
  gruvbox-custom = pkgs.vimUtils.buildVimPlugin {
    name = "gruvbox-custom";
    src = pkgs.fetchFromGitHub {
      owner = "ellisonleao";
      repo = "gruvbox.nvim";
      rev = "58a2cda2e953a99e2f87c12b7fb4602da4e0709c";
      sha256 = "tuoeJTCtb6Jx4KPOQgMmSJ3V1Vy5oNzkgIJQ3PelsME=";
    };
  };

in {

  programs.neovim = {

      # gruvbox-nvim

    plugins = with pkgs.vimPlugins; [
      {
        plugin =  gruvbox-custom;

        config = ''
          lua << EOF
          require("gruvbox").setup({
            terminal_colors = true,
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
              strings = true,
              emphasis = true,
              comments = true,
              operators = false,
              folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            inverse = true,
            contrast = "hard",
            palette_overrides = {
              dark0_hard = "#1d2021",
            },
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
          })
          
          vim.o.background = "dark"
          vim.cmd("colorscheme gruvbox")
          EOF
        '';
      }
        
      vim-airline
      vim-airline-themes
      vim-devicons  

    ];
  };
}


