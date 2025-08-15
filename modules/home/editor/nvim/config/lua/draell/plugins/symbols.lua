return {
  -- Substituição automática
  {
    "gbprod/substitute.nvim",
    event = "VeryLazy",
    config = function()
      require("substitute").setup({
        rules = {
          { pattern = "=>", replace = "⇒", mode = { "i", "n", "v" }},
          { pattern = "->", replace = "→", mode = { "i", "n", "v" }},
          { pattern = "!=", replace = "≠", mode = { "i", "n", "v" }},
          { pattern = ">=", replace = "≥", mode = { "i", "n", "v" }},
          { pattern = "<=", replace = "≤", mode = { "i", "n", "v" }},
        }
      })
    end
  },

  -- Configuração de conceal
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if not opts.ensure_installed then opts.ensure_installed = {} end
      table.insert(opts.ensure_installed, "javascript")
      table.insert(opts.ensure_installed, "typescript")
      table.insert(opts.ensure_installed, "lua")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      
      -- Configuração de conceal para símbolos
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "javascript", "typescript", "lua", "python", "rust" },
        callback = function()
          vim.wo.conceallevel = 2
          vim.cmd([[
            syntax match Operator "=>" conceal cchar=⇒
            syntax match Operator "->" conceal cchar=→
            syntax match Operator ">=" conceal cchar=≥
            syntax match Operator "<=" conceal cchar=≤
            syntax match Operator "!=" conceal cchar=≠
            hi! link Conceal Operator
          ]])
        end
      })
    end
  }
}
