return {
  {
    "nvim-lua/plenary.nvim",
    lazy = false,  
    config = function()

      local path = require("plenary.path")
      local async = require("plenary.async")
      local job = require("plenary.job")



      vim.api.nvim_create_user_command("NewFile", function(args)
        local file_path = path:new(args.args):absolute()
        vim.fn.mkdir(path:new(file_path):parent().filename, "p")
        vim.cmd("edit " .. file_path)
      end, { nargs = 1 })


      vim.keymap.set("n", "<leader>rg", function()
        local term = vim.fn.input("🔍 Termo para buscar: ")
        if term ~= "" then
          job:new({
            command = "rg",
            args = { "--color=never", "--smart-case", term },
            on_exit = function(j, code)
              if code == 0 then
                print("Resultados salvos no quickfix!")
                vim.fn.setqflist({}, ' ', {
                  title = "Resultados do rg: "..term,
                  lines = j:result()
                })
                vim.cmd("copen")
              else
                print("Nada encontrado para: "..term)
              end
            end
          }):start()
        end
      end, { desc = "Busca com rg (plenary)" })

      
      vim.api.nvim_create_user_command("AsyncMake", function()
        async.run(function()
          local result = job:new({ command = "make" }):sync()
          vim.schedule(function()
            vim.notify("Build completo!\n" .. table.concat(result, "\n"), vim.log.levels.INFO)
          end)
        end)
      end, {})
    end
  }
}
