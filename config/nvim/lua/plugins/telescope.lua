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
      },
      extensions = {
        fzf = {}
      }
    }

    require("telescope").load_extension("fzf")
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>fd", builtin.find_files)     -- browse files in dirs
    vim.keymap.set("n", "<leader>fr", builtin.lsp_references) -- browse refs
    vim.keymap.set("n", "<leader>gs", builtin.git_status)     -- browse git status
    vim.keymap.set("n", "<leader>b", builtin.buffers)         -- browse open buffers
    vim.keymap.set("n", "<leader>h", builtin.help_tags)       -- browse all help

    vim.keymap.set("n", "<leader>en", function()              -- edit nvim config
      builtin.find_files {
        cwd = vim.fn.stdpath("config")
      }
    end)

    vim.keymap.set("n", "<leader>ep", function() -- edit nvim config
      builtin.find_files {
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
      }
    end)

    require("config.telescope.multigrep").setup()
  end,
}
