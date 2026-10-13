return {
  "folke/tokyonight.nvim",
  lazy = false,    -- load during startup
  priority = 1000, -- before all other start plugins
  config = function()
    vim.cmd([[colorscheme tokyonight-night]])
  end,
}
