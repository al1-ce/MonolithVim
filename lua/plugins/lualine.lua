-- local sysdep = require("utils.sysdep")

local current_signature = function()
    if not pcall(require, 'lsp_signature') then return end
    local sig = require("lsp_signature").status_line()
    sig = require("lsp_signature").status_line(vim.api.nvim_win_get_width(0) - 27 - sig.hint:len())
    if sig.hint == "" then
        return vim.fn.expand('%:t')
    else
        return "[ " .. sig.hint .. " ]" .. sig.label
    end
end

local red_means_looping = function()
    if not pcall(require, 'recorder') then return "[o o] Error!" end
    local status = require("recorder").recordingStatus()
    local regist = string.sub(require("recorder").displaySlots(), 6, 9);
    local time = vim.loop.now()
    local stage = math.floor((time / 250) % 4)
    if string.match(status, "Recording") then
        if stage == 0 then
            return "[o o] Recording..."
        end
        if stage % 4 == 1 then
            return "[o⠠o] Recording..."
        end
        if stage % 4 == 2 then
            return "[o⠤o] Recording..."
        end
        if stage % 4 == 3 then
            return "[o⠄o] Recording..."
        end
    else
        if regist == "[a]b" then
            return "[o o] Side A"
        else
            return "[o o] Side B"
        end
    end
end

local red_means_recording = function()
    if not pcall(require, 'recorder') then return { fg = vim.g.terminal_color_7 } end
    local status = require("recorder").recordingStatus()
    if string.match(status, "Recording") then
        return { fg = vim.g.terminal_color_9 }
    else
        return { fg = vim.g.terminal_color_7 }
    end
end

return {
    -- powerline
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            "meuter/lualine-so-fancy.nvim",
        },
        opts = {
            options = {
                icons_enabled = false,
                theme = 'gruvbox',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {
                        -- "NvimTree",
                        -- "lspsagaoutline",
                        -- "diff",
                        -- "undotree",
                        -- "SidebarNvim",
                        -- "TelescopePrompt",
                        -- "toggleterm"
                    },
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 250,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {
                    { 'fancy_mode', width = 3 }
                },
                lualine_b = {
                    {
                        'branch',
                        icon = '$',
                        align = 'left',
                    },
                    {
                        'diff',
                        colored = true,
                        symbols = { added = '+', modified = '~', removed = '-' }, -- Changes the symbols used by the diff.
                    },
                    {
                        'diagnostics',
                        -- diagnostics_color = {
                        --     -- Same values as the general color option can be used here.
                        --     error = 'DiagnosticError', -- Changes diagnostics' error color.
                        --     warn  = 'DiagnosticWarn', -- Changes diagnostics' warn color.
                        --     info  = 'DiagnosticInfo', -- Changes diagnostics' info color.
                        --     hint  = 'DiagnosticHint', -- Changes diagnostics' hint color.
                        -- },
                        symbols = { error = 'e', warn = 'w', info = 'i', hint = 'h' },
                    }
                },
                lualine_c = { current_signature, },
                lualine_x = {
                    -- {
                    --     require("noice").api.status.command.get,
                    --     cond = require("noice").api.status.command.has
                    -- },
                    {
                        'filetype',
                        icons_enabled = false,
                    },
                },
                lualine_y = {
                    { red_means_looping, color = red_means_recording },
                    -- 'location'
                },
                lualine_z = { 'progress' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'location', 'fileformat', },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    },

}
