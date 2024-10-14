-- local sysdep = require("utils.sysdep")

local function get_color(group, attr)
    return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end
-- vim.print(vim.inspect(vim.fn.synIDtrans(vim.fn.hlID("Normal"))))
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
        -- return { fg = vim.g.terminal_color_9 }
        return { fg = get_color("Keyword", "fg#") }
    else
        -- return { fg = get_color("lualine_c_normal", "fg#")}
        return {}
        -- return { fg = vim.g.terminal_color_7 }
    end
end

local function custom_gruvbox()
    -- [ a | b | c         x | y | z ]
    local colors = {
        black        = '#282828',
        white        = '#ebdbb2',
        red          = '#fb4934',
        green        = '#b8bb26',
        blue         = '#83a598',
        yellow       = '#fe8019',
        gray         = '#a89984',
        darkgray     = '#3c3836',
        lightgray    = '#504945',
        inactivegray = '#7c6f64',
    }

    return {
        normal = {
            a = { bg = colors.gray, fg = colors.black, gui = 'bold' },
            b = { bg = colors.darkgray, fg = colors.gray },
            c = { bg = colors.darkgray, fg = colors.gray },
        },
        insert = {
            a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
            b = { bg = colors.darkgray, fg = colors.gray },
            c = { bg = colors.darkgray, fg = colors.gray },
        },
        visual = {
            a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
            b = { bg = colors.darkgray, fg = colors.gray },
            c = { bg = colors.darkgray, fg = colors.gray },
        },
        replace = {
            a = { bg = colors.red, fg = colors.black, gui = 'bold' },
            b = { bg = colors.darkgray, fg = colors.gray },
            c = { bg = colors.darkgray, fg = colors.gray },
        },
        command = {
            a = { bg = colors.green, fg = colors.black, gui = 'bold' },
            b = { bg = colors.darkgray, fg = colors.gray },
            c = { bg = colors.darkgray, fg = colors.gray },
        },
        inactive = {
            a = { bg = colors.darkgray, fg = colors.gray, gui = 'bold' },
            b = { bg = colors.darkgray, fg = colors.gray },
            c = { bg = colors.darkgray, fg = colors.gray },
        },
    }
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
                -- theme = custom_gruvbox(),
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
                },
                lualine_c = {
                    {
                        'branch',
                        icon = '$',
                        align = 'left',
                    },
                    {
                        'diff',
                        colored = false,
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
                        colored = false,
                        symbols = { error = 'e', warn = 'w', info = 'i', hint = 'h' },
                    },
                    'filename',
                },
                lualine_x = {
                    -- {
                    --     require("noice").api.status.command.get,
                    --     cond = require("noice").api.status.command.has
                    -- },
                    {
                        'filetype',
                        icons_enabled = false,
                    },
                    { red_means_looping, color = red_means_recording },
                },
                lualine_y = {
                    -- { red_means_looping, color = red_means_recording },
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
