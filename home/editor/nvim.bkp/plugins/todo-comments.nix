{ config, lib, pkgs, ... }: {

  programs.neovim.plugins = with pkgs.vimPlugins; 
    [ {
      plugin = todo-comments-nvim;
      config = ''
        lua << EOF
        require("todo-comments").setup({
          signs = true,
          keywords = {
            FIX  = { icon = " ", color = "error" },
            TODO = { icon = " ", color = "info" },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning" },
            PERF = { icon = " ", color = "default" },
            NOTE = { icon = " ", color = "hint" },
            TEST = { icon = "⏲ ", color = "test" },
          }
        })
        EOF
      '';
  } ];
}


