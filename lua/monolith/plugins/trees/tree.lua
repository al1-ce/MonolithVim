local nvim_tree = require("nvim-tree")

local function my_on_attach(bufnr)
    local api = require('nvim-tree.api')
    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set('n', 'c',     api.fs.copy.filename,                  opts('Copy Name'))
    vim.keymap.set('n', 'y',     api.fs.copy.node,                      opts('Copy'))
end

nvim_tree.setup {
    on_attach = my_on_attach,
    auto_reload_on_write = true,
    disable_netrw = true,
    hijack_cursor = false,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    -- ignore_buffer_on_setup = false,
    -- open_on_setup = false,
    -- open_on_setup_file = false,
    open_on_tab = false,
    sort_by = "name",
    update_cwd = false,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    prefer_startup_root = true,
    view = {
        width = 25,
        -- hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
    },
    renderer = {
        indent_markers = {
            enable = false,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            },
        },
        icons = {
            -- symlink_arrow = "→",
            -- webdev_colors = false,
            -- show = {
            --     file = false,
            --     folder = false,
            --     folder_arrow = true,
            --     git = false
            -- }
            symlink_arrow = "→",
            webdev_colors = true,
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = false
            }

        },
        group_empty = true
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    update_focused_file = {
        enable = true, -- false 
        update_cwd = true,
        update_root = true, -- wasnt there
        ignore_list = {},
    },
    -- ignore_ft_on_setup = {},
    system_open = {
        cmd = "",
        args = {},
    },
    diagnostics = {
        enable = false,
        show_on_dirs = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    filters = {
        dotfiles = false,
        custom = {},
        exclude = {},
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 400,
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
        open_file = {
            quit_on_open = false,
            resize_window = false,
            window_picker = {
                enable = true,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
    log = {
        enable = false,
        truncate = false,
        types = {
            all = false,
            config = false,
            copy_paste = false,
            diagnostics = false,
            git = false,
            profile = false,
        },
    },
    tab = {
        sync = {
            open = true,
            close = true
        }
    }
}

vim.cmd([[
    highlight NvimTreeWindowPicker guifg=#1d2021 guibg=#928374  

    let g:undotree_SplitWidth = 25
]])

local keymap = vim.keymap

local function setKeymapFiletype(ft, name, mode, map, action)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = ft,
        group = vim.api.nvim_create_augroup(name, {clear = true}),
        callback = function()
            keymap.set(mode, map, action, {silent = true, buffer = true})
        end
    })
end

setKeymapFiletype('NvimTree', 'NvimTree_Help', 'n', '?', '<cmd>h nvim-tree-mappings-default<cr>')


-- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
