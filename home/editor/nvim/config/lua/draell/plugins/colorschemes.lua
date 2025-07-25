return {
  "marko-cerovac/material.nvim", -- Nome do plugin para Lazy.nvim
  config = function()
    -- Defina o estilo antes de carregar o tema
    vim.g.material_style = "palenight"

    -- Configure o tema Material
    require('material').setup({
      contrast = {
        terminal = false, -- Enable contrast for the built-in terminal
        sidebars = false, -- Enable contrast for sidebar-like windows (e.g., Neo-Tree)
        floating_windows = false, -- Enable contrast for floating windows
        cursor_line = false, -- Enable darker background for the cursor line
        lsp_virtual_text = false, -- Enable contrasted background for LSP virtual text
        non_current_windows = false, -- Enable contrasted background for non-current windows
        filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
      },

      styles = { -- Give comments style such as bold, italic, underline etc.
        comments = { italic = true }, -- Comentários em itálico
        strings = {}, -- Strings sem estilos extras
        keywords = { bold = true }, -- Palavras-chave em negrito
        functions = { undercurl = true }, -- Funções com sublinhado curvo
        variables = {}, -- Variáveis sem estilos extras
        operators = {}, -- Operadores sem estilos extras
        types = { italic = true }, -- Tipos em itálico
      },

     plugins = { -- Uncomment the plugins that you use to highlight them
        -- Available plugins:
        -- "coc",
        -- "colorful-winsep",
        -- "dap",
        -- "dashboard",
        -- "eyeliner",
        -- "fidget",
        -- "flash",
        -- "gitsigns",
        -- "harpoon",
        -- "hop",
        -- "illuminate",
        -- "indent-blankline",
        -- "lspsaga",
        -- "mini",
        -- "neogit",
        -- "neotest",
        -- "neo-tree",
        -- "neorg",
        -- "noice",
        -- "nvim-cmp",
        -- "nvim-navic",
        -- "nvim-tree",
        -- "nvim-web-devicons",
        -- "rainbow-delimiters",
        -- "sneak",
         "telescope",
        -- "trouble",
        -- "which-key",
        -- "nvim-notify",
    },

      disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = true, -- Ativa bordas entre janelas divididas verticalmente
        background = false, -- Prevent the theme from setting the background (use o fundo do terminal)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false, -- Ocultar linhas no final do buffer
      },

      high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = false, -- Enable higher contrast text for darker style
      },

      lualine_style = "stealth", -- Deixa a barra do lualine mais simples e discreta

      async_loading = true, -- Carrega partes do tema de forma assíncrona para startup mais rápido

      custom_colors = nil, -- Sobrescreva as cores padrão aqui, se necessário

      custom_highlights = {}, -- Ajuste os destaques de forma personalizada
    })

    -- Ative o tema
    vim.cmd("colorscheme material")

    -- Configuração do Lualine
    require('lualine').setup({
      options = {
        theme = 'material',
        section_separators = '',
        component_separators = '|',
      },
    })

    -- Configuração do Telescope
    require('telescope').setup({
      defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            preview_width = 0.6,
          },
        },
      },
    })

    -- Configuração do Neo-tree
    -- require("neo-tree").setup({
      -- filesystem = {
        -- filtered_items = {
          -- hide_dotfiles = false, -- Mostra arquivos iniciados com "."
          -- hide_gitignored = false, -- Mostra arquivos ignorados pelo Git
        -- },
        -- follow_current_file = true, -- Sincroniza o Neo-tree com o arquivo aberto
      -- },
      -- default_component_configs = {
        -- indent = {
          -- padding = 1, -- Ajuste o espaçamento da indentação
        -- },
      -- },
    -- })
  end,
}

