{ config, lib, pkgs, ... }: {

# TODO: update my homemanager/neovim to enable "dependencys"

  imports = [
    ./plugins
    ./colorschemes.nix
    ./lsp-things.nix
  ];

  programs.neovim = {

    enable = true;
    viAlias = true;    
    vimAlias = true;  
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [

      nvim-web-devicons
      
      nvim-lspconfig 

      plenary-nvim

      persistence-nvim

    ];


    #TODO: remove these two last lines

    extraLuaConfig = ''

    vim.opt.tabstop = 2          
    vim.opt.softtabstop = 2     
    vim.opt.shiftwidth = 2     
    vim.opt.expandtab = true  
    vim.opt.autoindent = true
   
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
      end
    })

    -- Some old options:
    vim.cmd("set clipboard+=unnamedplus")
    vim.cmd("set expandtab")
    vim.cmd("set tabstop=2")
    vim.cmd("set softtabstop=2")
    vim.cmd("set shiftwidth=2")
    vim.g.mapleader = " "
    vim.g.background = "light"
    vim.opt.swapfile = false
    
    -- Navigate vim panes better
    vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
    vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
    vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
    vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
    
    vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
    vim.wo.number = true
    
    vim.g.cornelis_use_global_binary = 1
    vim.g.cornelis_max_size = 30
    vim.g.cornelis_split_location = 'vertical'
    
    -- background configs to make it all transparent
    vim.opt.termguicolors = true
    vim.opt.background = "dark"
    vim.api.nvim_set_hl(0, "Normal", { bg = "#1d2021" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1d2021" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
    vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
    vim.api.nvim_set_hl(0, "SpecialKey", { bg = "none" })
    
    
    ---------------------
    
    
    local global = vim.g
    local o = vim.opt
    
    -- My VERY cool editor options
    -- usar ao abirr, how? o.`"             = true 
    
    o.number         = true
    o.relativenumber = true
    
    o.splitright     = true
    o.splitbelow     = true
    
    o.wrap           = false
    
    o.expandtab      = true
    -- o.tabstop        = 2
    
    -- it synchronizes with tabstop 
    -- o.shiftwidth     = 0
    
    o.virtualedit    = "block"
    o.clipboard      = "unnamedplus"
    
    --testar dps
    --o.scrolloff      = 999
    
    o.inccommand     = "split"
    
    o.ignorecase     = true
    
    o.syntax         = "on"
    
    -- o.autoindent     = true
    o.cursorline     = true
    
    o.encoding       = "UTF-8"
    o.ruler          = true
    
    o.mouse          = "a"
    o.title          = true
    o.hidden         = true
    
    o.ttimeoutlen    = 0
    o.wildmenu       = true
    o.showmatch      = true
    
    o.termguicolors  = true
    
    -- Folds
    o.foldcolumn     = "0"
    o.foldtext       = ""

    vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
    vim.keymap.set('n', '<leader>n', ':Neotree filesystem close left<CR>', {})
    '';


  };

  #TODO: nix lsp when?
  home.packages = with pkgs; [
    clang-tools              # Provides clangd
    haskell-language-server  # Provides haskell LSP

    fzf 
    xclip

    nodejs             # some lsps dependency Necessário para alguns LSPs
    python3            

    lua-language-server
    # nodePackages.pyright
    rust-analyzer
    nodePackages.typescript-language-server
    gopls
    clang-tools
    nodePackages.bash-language-server
    haskell-language-server
    nodePackages.vscode-langservers-extracted
    gleam

  ];

}


