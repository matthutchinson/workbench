print("advent of neovim")

require("config.lazy")

-- default tabbing 2 spaces
vim.opt.shiftwidth = 2

-- mirror with system clipboard
vim.opt.clipboard = "unnamedplus"

-- play with vim cmd to se lua highlight
-- vim.cmd [[hi @function.builtin.lua guifg=red]]

-- always show numbers as relative
vim.opt.number = true
vim.opt.relativenumber = true

-- auto create directory path when writing if path doesn't exist
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    local file = vim.fn.fnamemodify(args.match, ":p")
    local dir = vim.fn.fnamemodify(file, ":h")

    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- bindings to quickly run lua code
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>") -- file
vim.keymap.set("n", "<space>x", ":.lua<CR>") -- current line
vim.keymap.set("v", "<space>x", ":lua<CR>") -- selection

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.hl_op()
  end,
})
