return {
  'xiyaowong/transparent.nvim',
  priority = 1000,
  lazy = false,
  config = function()
    local transparent = require('transparent')
    transparent.setup({
      enable = true,
      extra_groups = {
        -- built-in float groups
        "NormalFloat",
        "FloatBorder",

        -- Telescope groups
        "TelescopeNormal",
        "TelescopeBorder",

        -- Noice groups (check Noice docs for all possible groups)
        "NoicePopupmenu",
        "NoicePopupmenuBorder",
        "NoiceCmdlinePopup",
        "NoiceCmdlinePopupBorder",
        -- etc.

        -- nvim-notify highlight groups
        "NotifyERRORBorder",
        "NotifyWARNBorder",
        "NotifyINFOBorder",
        "NotifyDEBUGBorder",
        "NotifyTRACEBorder",
        "NotifyERRORBody",
        "NotifyWARNBody",
        "NotifyINFOBody",
        "NotifyDEBUGBody",
        "NotifyTRACEBody",
        -- etc.

        -- nui.nvim highlight groups
        -- e.g. if you use NuiPopup, NuiSplit, etc.
        "NuiPopupBorder",
        "NuiPopupNormal",
        "NuiSplitBorder",
        "NuiSplitNormal",
      },
    })

    -- transparent.clear_prefix('lualine')
  end
}
