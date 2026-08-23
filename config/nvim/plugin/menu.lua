-- clear built in autocmds for default nvim.popupmenu
vim.api.nvim_clear_autocmds({
  event = "MenuPopup",
  group = "nvim.popupmenu",
})

-- clear default menu, has to be done with a vim command, not lua
vim.cmd [[
  aunmenu PopUp
  anoremenu PopUp.Inspect     <cmd>Inspect<CR>
  amenu PopUp.-1-             <NOP>
  anoremenu PopUp.Definition  <cmd>lua vim.lsp.buf.definition()<CR>
  anoremenu PopUp.References  <cmd>Telescope lsp_references<CR>
  nnoremenu PopUp.Back        <C-t>
  amenu PopUp.-2-             <NOP>
  amenu     PopUp.URL         gx
]]

local group = vim.api.nvim_create_augroup("nvim_popupmenu", { clear = true })

--- http://google.com -- gx will open this, but we add a menu item for this above

vim.api.nvim_create_autocmd("MenuPopup", {
  pattern = "*",
  group = group,
  desc = "Custom PopUp Setup",
  callback = function()
    -- disable all items
    vim.cmd [[
      amenu disable PopUp.Definition
      amenu disable PopUp.References
      amenu disable PopUp.URL
    ]]

    -- enable if we have a buffer
    if vim.lsp.get_clients({ bufnr = 0 })[1] then
      vim.cmd [[
        amenu enable PopUp.Definition
        amenu enable PopUp.References
      ]]
    end

    -- contextual popup based on url on current line
    local urls = require("vim.ui")._get_urls()
    if vim.startswith(urls[1], "http") then
      vim.cmd [[
        amenu enable PopUp.URL
        amenu enable PopUp.-2-
      ]]
    end
  end,
})
