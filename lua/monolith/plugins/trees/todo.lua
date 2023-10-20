
require("todo").setup({
    keywords = {
        FIX = {
            icon = " ", -- used for the sign, and search results
            -- can be a hex color, or a named color
            -- named colors definitions follow below
            color = "#cc241d",
            -- a set of other keywords that all map to this FIX keywords
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }
            -- signs = false -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "#458588" },
        WARN = { icon = " ", color = "#d79921", alt = { "WARNING" } },
        NOTE = { icon = " ", color = "#689d6a", alt = { "INFO" } }
    },
    highlight = {
        keyword = 'fg',
        after = 'empty',
    }
})

