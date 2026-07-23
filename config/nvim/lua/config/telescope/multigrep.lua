-- custom picker - see https://youtu.be/xdXE1tOT-qg?si=edobv9qRjHqNKjX-
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

local M = {}

-- how to have same linting highlighting as yt?
local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local places = vim.split(prompt, "  ")
      local args = { "rg" }
      if places[1] then
        table.insert(args, "-e")
        table.insert(args, places[1])
      end

      if places[2] then
        table.insert(args, "-g")
        table.insert(args, places[2])
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten {
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
      }
    end,

    -- how we format entries
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers.new(opts, {
    debounce = 100,
    prompt_title = "Multi-Grep",
    finder = finder,
    previewer = conf.grep_previewer(opts),         -- use default previewer
    sorter = require("telescope.sorters").empty(), -- don't sort, already sorted by rg command
  }):find()
end

M.setup = function()
  vim.keymap.set("n", "<leader>fg", live_multigrep)
end

return M
