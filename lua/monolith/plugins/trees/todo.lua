
require("todo-comments").setup({
    keywords = {
        FIX = {
            icon = " ", -- used for the sign, and search results
            -- can be a hex color, or a named color
            -- named colors definitions follow below
            color = "error",
            -- color = "#cc241d",
            -- a set of other keywords that all map to this FIX keywords
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }
            -- signs = false -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        LINK = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    highlight = {
        keyword = 'fg',
        after = 'empty',
    }
})

