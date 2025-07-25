{ config, lib, pkgs, ... }: {

  programs.neovim = {

    extraPackages = with pkgs; [
      pkgs.tree-sitter 
    ];

    #TODO: Fixar alguma opcao bugada aqui!
    plugins = with pkgs.vimPlugins; 
      [ {
        plugin = nvim-treesitter;
        config = ''
          lua << EOF
          require("nvim-treesitter.configs").setup({
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            parser_install_dir = vim.fn.stdpath("data") .. "/treesitter",
          })
          
          -- Garante que o Neovim encontrará os parsers
          vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/treesitter")
          EOF
        '';
      } ];
  };

}


