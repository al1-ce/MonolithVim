local nvim_tree = require("nvim-tree")

nvim_tree.setup {
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
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        mappings = {
            custom_only = false,
            list = {
                -- user mappings go here
            },
        },
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
            symlink_arrow = "→",
            webdev_colors = false,
            show = {
                file = false,
                folder = false,
                folder_arrow = true,
                git = false
            }
        },
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    update_focused_file = {
        enable = true, -- false 
        update_cwd = false,
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
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
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

-- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
