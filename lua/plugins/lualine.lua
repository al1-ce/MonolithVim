---@diagnostic disable: undefined-field
local hl = require("utils.hlgroups")

local red_means_looping
local red_means_recording
local keyword_fg = hl("Keyword").fg

red_means_looping = function()
    if not pcall(require, 'recorder') then return "[o o] Error!" end
    local recorder = require("recorder")
    local regist = string.sub(recorder.displaySlots(), 6, 9);
    local stage = math.floor((vim.loop.now() / 250) % 4)

    if string.match(recorder.recordingStatus(), "Recording") then
        if stage == 0 then return "[o o] Recording..." end
        if stage % 4 == 1 then return "[o⠠o] Recording..." end
        if stage % 4 == 2 then return "[o⠤o] Recording..." end
        if stage % 4 == 3 then return "[o⠄o] Recording..." end
    else
        local tape = "[o o] " .. regist
        if regist == "[a]" or regist == "[a]b" then return "[o o] Side A" end
        if regist == "a[ ]" or regist == "a[b]" then return "[o o] Side B" end
        return tape
    end
end

red_means_recording = function()
    if not pcall(require, 'recorder') then return {} end
    local recorder = require("recorder")
    if string.match(recorder.recordingStatus(), "Recording") then return { fg = keyword_fg } else return {} end
end

return {
    -- powerline
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', "meuter/lualine-so-fancy.nvim", },
        config = function()
            local lualine_config = {
                options = {
                    -- theme = get_theme(),
                    icons_enabled = false,
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = { statusline = 250, tabline = 1000, winbar = 1000, }
                },
                sections = {
                    lualine_a = {
                        { 'fancy_mode', width = 3 }
                    },
                    lualine_b = {},
                    lualine_c = {
                        { 'branch', icon = '$', align = 'left', },
                        {
                            'diff',
                            colored = false,
                            symbols = { added = '+', modified = '~', removed = '-' },
                        },
                        -- {
                        --     'diagnostics',
                        --     colored = false,
                        --     symbols = { error = 'e', warn = 'w', info = 'i', hint = 'h' },
                        -- },
                        'filename',
                    },
                    lualine_x = {
                        { 'filetype',        icons_enabled = false, },
                        { red_means_looping, color = red_means_recording },
                    },
                    lualine_y = {},
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

            local lualine = require("lualine")
            local lualine_theme = require("pfunc.lualine-theme")
            local get_theme = lualine_theme.get_theme

            local source_func = function ()
                keyword_fg = hl("Keyword").fg
                lualine_config.options.theme = get_theme()
                lualine.setup(lualine_config)
            end

            source_func()

            require("colorscheme").on_reload(source_func)
        end
    },

}


