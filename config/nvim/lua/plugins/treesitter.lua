return {
  -- also npm install -g tree-sitter-cli
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install {
      "lua", "ruby", "javascript", "html", "css", "vim", "vimdoc", "markdown", "c", "json",
    }
  end
}
