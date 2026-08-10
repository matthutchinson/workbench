-- play with vim cmd to see built in lua functions highlighted in another colour
-- execute a command exactly like typing :hi @function.builtin.lua guifg=red
--
-- Lua Basics
-- [[ ]] is a long string, equivalent to '' or "", but escapes quotes OK
-- () around calling a lua function are optional
-- @ is the start of a treesitter capture (identifying the highlight target group)
-- vim.cmd [[highlight @function.builtin.lua guibg=#441122]]

print("advent of neovim!")

require("config.lazy")

-- default tabbing (spaces)
vim.opt.shiftwidth = 2

-- mirror with system clipboard
vim.opt.clipboard = "unnamedplus"

-- always show numbers as relative
vim.opt.number = true
vim.opt.relativenumber = true

-- auto create directory path when writing if path doesn't exist
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    -- Skip URL buffers (e.g. oil://) whose name isn't a real filesystem path,
    -- otherwise mkdir() creates a bogus "oil:/..." directory tree.
    if args.match:find("://") then
      return
    end
    local file = vim.fn.fnamemodify(args.match, ":p")
    local dir = vim.fn.fnamemodify(file, ":h")

    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- bindings

-- quickly run lua code
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>") -- file
vim.keymap.set("n", "<leader>x", ":.lua<CR>")                 -- current line
vim.keymap.set("v", "<leader>x", ":lua<CR>")                  -- selection

-- quickfix window
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")   -- Alt+j next item (meta is alt key)
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")   -- Alt+k prev item
vim.keymap.set("n", "<M-w>", "<cmd>cwindow<CR>") -- Alt+w open quickfix window if we have results

local function toggle_quickfix()
  local qf_win = nil
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      qf_win = win.winid
      break
    end
  end

  if qf_win then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end

vim.keymap.set("n", "<M-q>", toggle_quickfix, { desc = "Toggle quickfix window" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.hl_op()
  end,
})

-- terminals should not have line numbers
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})
-- back to normal mode in terminals with esc,esc
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local chan_id = 0
vim.keymap.set("n", "<leader>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
  vim.cmd.startinsert()

  chan_id = vim.bo.channel
end)

vim.keymap.set("n", "<leader>echo", function()
  vim.fn.chansend(chan_id, { "echo 'hi'\r\n" })
end)
