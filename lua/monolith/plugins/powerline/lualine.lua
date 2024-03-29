local current_signature = function()
    if not pcall(require, 'lsp_signature') then return end
    local sig = require("lsp_signature").status_line()
    sig = require("lsp_signature").status_line(vim.api.nvim_win_get_width(0) - 27 - sig.hint:len())
    if sig.hint == "" then
        return vim.fn.expand('%:t')
    else
        return "「" .. sig.hint .. "」" .. sig.label
    end
end

require('lualine').setup {
    options = {
        icons_enabled = true,
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
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { {'fancy_mode', width=3} },
        lualine_b = {'branch', 'fancy_diff', 'diagnostics' },
        lualine_c = { current_signature, },
        lualine_x = {
            {
                require("noice").api.status.command.get,
                cond = require("noice").api.status.command.has
            },
            'filetype'
        },
        lualine_y = { 'location' },
        lualine_z = { 'progress'  }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'location', 'fileformat',  },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
