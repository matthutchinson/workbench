return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  opts = {
    keymap = { preset = 'cmdline' }, -- default for auto popup, cmdline for tab/s-tab
    appearance = { nerd_font_variant = 'mono' },
    completion = {
      menu = { auto_show = false },        -- toggle always showing completion menu
      documentation = { auto_show = true } -- toggle floating doc window on/off
    },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
