return {
  'mrcjkb/haskell-tools.nvim',
  version = '^4',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- Apenas carrega o plugin sem configurar nada
    require('haskell-tools')

    -- Tenta usar funcionalidades depois de um delay
    vim.defer_fn(function()
      local ok, ht = pcall(require, 'haskell-tools')
      if ok then
        -- Configurações seguras aqui
        vim.notify("Haskell Tools carregado com sucesso!")
      else
        vim.notify("Falha ao carregar Haskell Tools: " .. ht, vim.log.levels.ERROR)
      end
    end, 1000) -- 1 segundo de delay
  end
}
