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
        ['TRUE'] = 'FALSE',
        ['True'] = 'False',
        ['1'] = '0',
        ['public'] = 'private',
        ['[ ]'] = '[x]',
        ['++'] = '--',
        ['+'] = '-',
        ['""'] = "''",
        ['struct'] = 'class',
        ['always'] = 'never',
        ['float'] = 'double',
        ['top'] = 'bottom',
        ['left'] = 'right',
        ['relative'] = 'absolute',
        ['white'] = 'black',
    },
    remove_default_keybinds = true,
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

require('hlslens').setup()

local open = io.open

local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

local function read_file(path)
    local file = open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

local codestats = os.getenv("HOME") .. "/.config/codestats.lua"

if (file_exists(codestats)) then
    require('monolith.config.codestats.init').setup({
        token = read_file(codestats):sub(1, -2)
    })
    -- require("notify")(read_file(codestats), "warn", {title="Title"}) 
else
    -- require("notify")("not", "warn", {title="Title"}) 
    -- require('monolith.config.codestats.init').setup()
end



