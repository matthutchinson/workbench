return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- optional but recommended
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    require("telescope").setup {
      pickers = {
        find_files = {
          theme = "ivy",
        },
        buffers = {
          theme = "dropdown",
        }
      }
    }

    local telescope = require("telescope.builtin")
    local themes = require("telescope.themes")

    vim.keymap.set("n", "<space>", telescope.find_files)      -- browse files
    vim.keymap.set("n", "<space>r", telescope.lsp_references) -- browse refs
    vim.keymap.set("n", "<space>gs", telescope.git_status)    -- browse git status
    vim.keymap.set("n", "<space>b", telescope.buffers)        -- browse open buffers
    vim.keymap.set("n", "<space>h", telescope.help_tags)      -- browse all help

    vim.keymap.set("n", "<space>en", function()               -- edit nvim config
      telescope.find_files {
        cwd = vim.fn.stdpath("config")
      }
    end)
  end,
}
