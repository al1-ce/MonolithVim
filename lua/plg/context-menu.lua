return {
    {
        -- "al1-ce/context-menu.nvim",
        dir = "/g/al1-ce/context-menu.nvim",
        enabled = false,
        opts = {
            menu_items = {
                {
                    name = "Run File",
                    hl = { bg = "#efefef", fg = "#efefef" },
                    ft = { "!markdown" },
                    cmd = function(context)
                        if context.ft == "lua" then
                            return vim.cmd([[source %]])
                        elseif context.ft == "javascript" then
                            return vim.print("run javascript:: haven't impl yet")
                        end
                    end,
                },
                {
                    name = "Sub CMD",
                    order = 1,
                    hl = "String",
                    ft = { "!markdown" },
                    sub_menu = {
                        { name = " 1.──────────── ", cmd = function() end },
                        { name = " 1.1 Cde::Format", cmd = vim.lsp.buf.format, },
                        { name = " 1.2 Coe::Format", cmd = vim.lsp.buf.format, },
                        {
                            name = "Sub CMD",
                            hl = "String",
                            ft = { "!markdown" },
                            sub_menu = {
                                { name = " 1.──────────── ", cmd = function() end },
                                { name = " 1.1 Cde::Format", cmd = vim.lsp.buf.format, },
                                { name = " 1.2 Coe::Format", cmd = vim.lsp.buf.format, },
                            },
                        },
                    },
                },
                { name = " 0──────────── ", hl = "Float", cmd = function() end },
                { name = " 1Code::Fomat", cmd = vim.lsp.buf.format, },
                { name = " 2de::Fomt", cmd = vim.lsp.buf.format, },
                { name = " 3Code::Forat", hl = "DiagnosticUnderlineError", cmd = vim.lsp.buf.format, },
                { name = " 4Code::Forat", cmd = vim.lsp.buf.format, },
                { name = " 5Code::ormat", cmd = vim.lsp.buf.format, },
                { name = " 6Code::Forat", cmd = vim.lsp.buf.format, },
                { name = " 7Code::rma", cmd = vim.lsp.buf.format, },
                { name = " 8Code::Format", cmd = vim.lsp.buf.format, },
            },
            debug = false,
            keymap = {
                close = { "q", "<ESC>" },
                confirm = { "<CR>", "o" },
                back = { "h", "<left>" }
            },
            window = {
                style = "SignColumn",
                border_style = "SignColumn",
                border = "double",
                cursor = { underline = true },
                separator = "-",
                submenu = ">",
            },
        },
        keys = {
            { "<leader>cc", function() require("context-menu").trigger_context_menu() end, mode = "n", noremap = true, silent = true, desc = "[C]ontext [M]enu" }
        },
        event = "VimEnter"
    }
}
