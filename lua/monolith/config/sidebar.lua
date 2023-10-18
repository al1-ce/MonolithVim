local sidebar = require("sidebar-nvim")
local opts = {
    open = false,
    side = 'right',
    initial_width = 25,
    sections = {
        "diagnostics",
        "git",
        "todos",
        require("dap-sidebar-nvim.breakpoints")
    },
    section_separator = {''},
    todos = {
        ignored_paths = {'~'},
        initially_closed = false
    }
}
sidebar.setup(opts)
