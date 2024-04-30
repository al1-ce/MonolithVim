-- Special case coz jank
local notify = require('notify')
-- vim.notify = notify
--
-- _G.print = function(...)
--     local print_safe_args = {}
--     local _ = {...}
--     for i=1, #_ do
--         table.insert(print_safe_args, tostring(_[i]))
--     end
--     local message = table.concat(print_safe_args, ' ')
--     vim.notify(message, vim.log.levels.INFO)
-- end
-- _G.error = function(...)
--     local print_safe_args = {}
--     local _ = {...}
--     for i=1, #_ do
--         if tostring(_[i]) == 'UfoFallbackException' then return end
--         table.insert(print_safe_args, tostring(_[i]))
--     end
--     local message = table.concat(print_safe_args, ' ')
--     vim.notify(message, vim.log.levels.ERROR)
-- end

notify.setup({
    background_color = '#000000',
    stages = 'slide',

    on_open = function (win)
      vim.api.nvim_win_set_config(win, { border = "single" })
    end,
    render = "wrapped-compact",
    minimum_width = 0,
    -- require("notify")("My super important message", "warn", {title="Title"})
})
