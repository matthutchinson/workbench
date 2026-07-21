return {
  "neovim/nvim-lspconfig",
  dependencies = { {
    "folke/lazydev.nvim",
    ft = "lua",   -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  },
  config = function()
    vim.lsp.enable('lua_ls')     -- brew install lua-language-server
    vim.lsp.enable('ruby_lsp')   -- gem install ruby-lsp

    -- e.g ff to format the current buffer (in normal mode) would be
    vim.keymap.set("n", "ff", function() vim.lsp.buf.format() end)

    vim.api.nvim_create_autocmd('LspAttach', {
      -- note no buffer arg, happing on all attaches in nv
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if not client then return end

        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
          -- when supported, always format the current buffer on save
          -- or also, you can check ft in here with
          -- if vim.bo.filtetype == "lua" == "lua"
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1500 })
            end,
          })
        end
      end,
    })
  end,
}
