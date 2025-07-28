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

-- LSP
-- Configurações para handlers de hover e signatureHelp
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded",
    focusable = false, -- Evita que a janela flutuante roube o foco
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "rounded",
    focusable = false, -- Evita que a janela flutuante roube o foco
  }
)

-- Ativar diagnósticos em tempo real
vim.diagnostic.config({
  virtual_text = true,          -- Texto virtual ao lado do código
  float = {
    border = "rounded",
    focusable = false, -- Evita que a janela flutuante roube o foco
    source = "always", -- Mostra a fonte do diagnóstico
  },
})

-- Função para abrir diagnósticos sem sair do modo insert
local function open_diagnostic_float()
  local mode = vim.api.nvim_get_mode().mode
  vim.diagnostic.open_float(nil, {
    scope = "line",
    border = "rounded",
    focusable = false, -- Evita roubar o foco
  })
  if mode == "i" then
    vim.api.nvim_command("startinsert")
  end
end

-- Função para abrir hover sem sair do modo insert
local function open_lsp_hover()
  local mode = vim.api.nvim_get_mode().mode
  vim.lsp.buf.hover()
  if mode == "i" then
    vim.api.nvim_command("startinsert")
  end
end

-- Função de debounce para evitar chamadas excessivas
local function debounce(ms, fn)
  local timer = vim.loop.new_timer()
  return function(...)
    local argv = { ... }
    timer:stop()
    timer:start(ms, 0, function()
      vim.schedule(function()
        fn(unpack(argv))
      end)
    end)
  end
end

-- Atualizar diagnósticos e hover automaticamente a cada caractere no modo insert
vim.api.nvim_create_autocmd("TextChangedI", {
  callback = debounce(100, open_diagnostic_float),
  pattern = "*", -- Aplica a todos os tipos de arquivo
})

vim.api.nvim_create_autocmd("TextChangedI", {
  callback = debounce(100, open_lsp_hover),
  pattern = "*", -- Aplica a todos os tipos de arquivo
})

-- Fechar janelas flutuantes ao sair do modo insert
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.cmd("pclose") -- Fecha todas as janelas flutuantes
  end,
  pattern = "*",
})

-- Mapeamentos para modo normal (mantidos para uso manual)
local map = vim.keymap.set
map('n', 'K', vim.lsp.buf.hover, { desc = "Mostrar documentação" })
map('n', 'gd', vim.lsp.buf.definition, { desc = "Ir para definição" })
map('n', '<leader>d', vim.diagnostic.open_float, { desc = "Diagnóstico detalhado" })
