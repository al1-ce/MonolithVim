require("barbar").setup({
    -- Enable/disable animations
    animation = true,

    -- Automatically hide the tabline when there are this many buffers left.
    -- Set to any value >=0 to enable.
    auto_hide = false,

    -- Enable/disable current/total tabpages indicator (top right corner)
    tabpages = true,

    -- Enables/disable clickable tabs
    --  - left-click: go to buffer
    --  - middle-click: delete buffer
    clickable = true,

    -- Excludes buffers from the tabline
    -- exclude_ft = { 'javascript' },
    -- exclude_name = { 'package.json' },

    -- Valid options are 'left' (the default), 'previous', and 'right'
    -- focus_on_close = 'left',

    -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
    hide = { extensions = true, inactive = true },

    -- Disable highlighting alternate buffers
    highlight_alternate = false,

    -- Disable highlighting file icons in inactive buffers
    highlight_inactive_file_icons = false,

    -- Enable highlighting visible buffers
    highlight_visible = true,
})
