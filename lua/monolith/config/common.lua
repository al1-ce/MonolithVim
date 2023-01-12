-- Plugin setup

local g = vim.g -- global variables

require("range-highlight").setup({})
require('neoclip').setup({})
require('smart-splits').setup({})

g.EasyMotion_do_mapping = 0 -- Disable default mappings
g.EasyMotion_use_upper = 0
g.EasyMotion_smartcase = 1
g.EasyMotion_use_smartsign_us = 1

g.undotree_SplitWidth = 10
g.undotree_WindowLayout = 3

g.better_escape_shortcut = 'jj'
g.better_escape_interval = 200

require("colorizer").setup({
    filetypes = { "*" },
    user_default_options = { names = false, },
})

require("link-visitor").setup({
    open_cmd = nil,
    silent = true
})

require("toggleterm").setup({
    hide_numbers = true,
    start_in_insert = false,
    autochdir = false,
    shade_terminals = false,
    winblend = 0
})

require("winshift").setup({
    keymaps = {
        disable_defaults = false, 
    }
})

require('pqf').setup({
    signs = {
        error = '',
        warning = '',
        info = '',
        hint = ''
    },
    show_multiple_lines = false
})

require('glow').setup({
    style = "dark",
    border = 'solid',
    width_ratio = 0.7,
    height_ratio = 0.7,
})

require('notify').setup({
    background_color = '#000000',
    stages = 'slide',

    on_open = function (win)
      vim.api.nvim_win_set_config(win, { border = "single" })
    end,
    -- require("notify")("My super important message", "warn", {title="Title"}) 
})

require('nvim-toggler').setup({
    inverses = {
        ['1'] = '0'
    }
})

require("sessions").setup({
    session_filepath = vim.fn.stdpath("data") .. "/sessions",
    absolute = true,
})

require'nvim-lastplace'.setup {
    lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
    lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
    lastplace_open_folds = true
}

require('spectre').setup({})
require('neodev').setup()

require('remember_me').setup({
    -- https://github.com/EricDriussi/remember-me.nvim
})

-- g.asyncrun_exit = "Start! aplay ~/.config/nvim/res/notify1.wav"
g.asyncrun_open = 8
