return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true, 
      sign_priority = 8,

      keywords = {
        FIX = {
          icon = " ", 
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, 
          
        },

        -- TODO: ADD MORE! Theres things about time, by example
        TODO  = { icon = " ", color = "info" },
        ERROR = { icon = "! ", color = "error" },
        HACK  = { icon = " ", color = "warning" },
        WARN  = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF  = { icon = " ",                    alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE  = { icon = " ", color = "hint",    alt = { "INFO" } },
        TEST  = { icon = "⏲ ", color = "test",    alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE",
        bg = "BOLD", 
      },
      merge_keywords = true,
      
      highlight = {
        multiline = true,
        multiline_pattern = "^.", 
        multiline_context = 10, 
        before = "",
        keyword = "wide",
        after = "fg",
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true, 
        max_line_len = 400, 
        exclude = {},
      },
      
      
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        
       
        pattern = [[\b(KEYWORDS):]],
        
      },
    },

    config = function(_, opts)
      require("todo-comments").setup(opts)

      local telescope = require("telescope")
      telescope.load_extension("todo-comments")


      vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "[S]earch [T]odos" })

      vim.keymap.set("n", "<leader>sa", function()
        require("telescope").extensions["todo-comments"].todo()
      end, { desc = "Buscar TODOs" })

    end
  }
}
