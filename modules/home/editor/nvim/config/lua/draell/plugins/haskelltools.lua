return {
  'mrcjkb/haskell-tools.nvim',
  version = '^4',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- Apenas carrega o plugin sem configurar nada
    require('haskell-tools')

  end
}
