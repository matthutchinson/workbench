return {
  -- do we need to nest the table {}?
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('ruby_lsp')
    end,
  }
}
