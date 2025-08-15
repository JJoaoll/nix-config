return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
        -- ERROR: lua_ls is having some problems
        -- TODO: Have a lua lsp
				ensure_installed = {"jdtls"},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Pyright LSP
			lspconfig.pyright.setup({
				on_attach = function(client, bufnr)
					print("LSP anexado ao buffer", bufnr)
					local opts = { noremap = true, silent = true }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic", -- Altere para "strict" se quiser verificações mais rígidas
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
          },
        },
      })

      -- Outro LSP's:
      lspconfig.jdtls.setup({})
      --lspconfig.tsserver.setup({})
      lspconfig.rust_analyzer.setup({})

      -- Defina o Agda Language Server como uma configuração personalizada
      --lspconfig.agda_language_server = {
      --  default_config = {
      --    cmd = { "cornelis" },  -- Verifique se este caminho está correto
      --    filetypes = { "agda" },
      --    root_dir = lspconfig.util.root_pattern("*.agda", ".git"),
      --    on_attach = function(client, bufnr)
      --      print("Agda Language Server attached.")
      --    end,
      --  }
      --}
       -- Configuração da instância do servidor
       -- lspconfig.agda_language_server.setup({
       -- cmd = { "cornelis" },
       -- filetypes = { "agda" },
       -- root_dir = lspconfig.util.root_pattern("*.agda", ".git"),
      -- })
      
      
       
--require'lspconfig'.hls.setup{
--    cmd = { "haskell-language-server", "--lsp" },  -- ou "haskell-language-server-wrapper" se necessário
--    filetypes = { 'haskell', 'lhaskell' },
--    root_dir = require'lspconfig'.util.root_pattern("stack.yaml", "cabal.project", ".git"),
--    settings = {
--        haskell = {
----            formattingProvider = "fourmolu", -- ou "ormolu" dependendo do que você prefere
----            hlintOn = true,
----        },
----    },
----}
----}

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {}) -- Exibir o diagnóstico em um balão
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {}) -- Ir para o erro anterior
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {}) -- Ir para o próximo erro
		end,
	},
}
