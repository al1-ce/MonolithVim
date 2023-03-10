local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")

require("telescope").setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        file_sorter = sorters.get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = sorters.get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = previewers.buffer_previewer_maker,
        mappings = {
            n = { ["q"] = actions.close },
            i = { ["<esc>"] = actions.close },
        },
    }
})

require('telescope').load_extension('projects')
require('telescope').load_extension('file_browser')
-- require('telescope').load_extension('yabs')
-- require('telescope').load_extension('coc')
require('telescope').load_extension('neoclip')
require("telescope").load_extension("vimspector")
require("telescope").load_extension("software-licenses")
require('telescope').load_extension('heading')
require('telescope').load_extension('packer')
require('telescope').load_extension('notify')
-- require('telescope').load_extension('symbols')
require('telescope').load_extension('howdoi')

require("todo").setup({
    keywords = {
        FIX = {
            icon = " ", -- used for the sign, and search results
            -- can be a hex color, or a named color
            -- named colors definitions follow below
            color = "#cc241d",
            -- a set of other keywords that all map to this FIX keywords
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }
            -- signs = false -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "#458588" },
        WARN = { icon = " ", color = "#d79921", alt = { "WARNING" } },
        NOTE = { icon = " ", color = "#689d6a", alt = { "INFO" } }
    },
    highlight = {
        keyword = 'fg',
        after = 'empty',
    }
})

require('telescope').setup({
    extensions = {
        howdoi = {
            num_answers = 5,
            -- pager_command = 'bat --tabs 4 --color always --paging always --theme gruvbox-dark',
            pager_command = 'bat --tabs 4 --color always --paging always --theme gruvbox-dark',
        },
    },
    pickers = {
        colorscheme = {
            enable_preview = true
        }
    }
})

require("project_nvim").setup({
    show_hidden = true,
    silent_chdir = false,
    patterns = { "dub.json", "dub.sdl", ".git", "src", "source" }
})

require("urlview").setup({
    default_picker = "telescope",
})


