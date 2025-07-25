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
o.tabstop        = 2

-- it synchronizes with tabstop 
o.shiftwidth     = 0

o.virtualedit    = "block"
o.clipboard      = "unnamedplus"

--testar dps
--o.scrolloff      = 999

o.inccommand     = "split"

o.ignorecase     = true

o.syntax         = "on"

o.autoindent     = true
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


