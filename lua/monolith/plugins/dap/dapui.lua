local dap = require('dap')
local dapui = require("dapui")

dapui.setup({
    layouts = {
        {
            elements = {
                -- { id = "scopes", size = 2 },
                "breakpoints",
                "watches",
                -- "stacks",
                "scopes",
                -- "repl"
            },
            size = 23,
            position = "left"
        }
    },
    controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "breakpoints",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "",
            terminate = "",
        },
    },
})
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.after.event_breakpoint["dapui_config"] = function()
    dapui.open()
end
-- Next two causes some trouble, might turn them back on later
dap.listeners.before.event_terminated["dapui_config"] = function()
    -- dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    -- dapui.close()
end
