return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  version = '1.*',
  config = function()
    require('blink.cmp').setup({
      keymap = {
        preset = 'none',
        ['<C-n>'] = { 'snippet_forward', 'select_next', 'fallback' },
        ['<C-p>'] = { 'snippet_backward', 'select_prev', 'fallback' },
        ['<C-y>'] = { 'select_and_accept' },
        ['<C-i>'] = { 'show' },
        ['<C-o>'] = { 'show' },
        ['<C-u>'] = { 'scroll_documentation_up' },
        ['<C-d>'] = { 'scroll_documentation_down' },
        ['<C-l>'] = { 'hide', 'fallback' },
        ['<Tab>'] = { 'fallback' },
      },
      completion = {
        list = { max_items = 50 },
        documentation = { auto_show = false },
        menu = {
          auto_show_delay_ms = 100,
          draw = {
            columns = {
              { 'kind_icon' },
              { 'label', gap = 1 },
              { 'kind' },
            },
          },
        },
        accept = {
          auto_brackets = {
            semantic_token_resolution = { enabled = false },
          },
        },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
      signature = { enabled = true },
      sources = {
        min_keyword_length = 2,
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
          lsp = { async = true, timeout_ms = 500 },
          buffer = { max_items = 5, min_keyword_length = 3 },
          snippets = { max_items = 8 },
          path = { max_items = 15 },
        },
      },
    })
  end,
}
