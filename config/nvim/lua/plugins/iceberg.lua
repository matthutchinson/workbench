return {
  'cocopon/iceberg.vim',
  lazy = false,      -- load during startup
  priority = 1000,   -- before all other start plugins
  config = function()
    vim.cmd([[colorscheme iceberg]])
  end,
}
