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
        ['<C-d>'] = { 'scroll_documentation_up' },
        ['<C-f>'] = { 'scroll_documentation_down' },
        ['<C-l>'] = { 'hide', 'fallback' },
        ['<Tab>'] = { 'fallback' },
      },
      completion = {
        documentation = { auto_show = true },
        menu = {
          draw = {
            columns = {
              { 'kind_icon' },
              { 'label', gap = 1 },
              { 'kind' },
            },
          },
        },
      },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
    })
  end,
}
