return {
    -- FZF [ ;ff ;fr ;fp ;fg \ff ... ]
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local fzf = require("fzf-lua")
            -- List of what I usually wouldn't need to see in fzf
            local file_ignores = {
                -- images
                "png", "jpg", "jpeg", "gif", "bmp", "ico", "webp",
                "gpl", "kra", "tiff", "psd", "pdf", "dwg", "svg",
                -- fonts
                "ttf", "woff", "otf",
                -- audio
                "ogg", "mp3", "wav", "aiff", "flac", "oga", "mogg", "raw", "wma",
                -- video
                "mp4", "mkv", "webm", "avi", "amv", "mpg", "mpeg", "mpv",
                "m4v", "svi", "wmv",
                -- binaries, libs and packages assets
                "bin", "exe", "o", "so", "dll", "a", "dylib",
                "rgssad", "pak", "pdb", "bank", "ovl", "dat",
                "mdi", "ad", "dig", "pat", "lev", "mq", "mob",
                "pk3", "wad", "bak", "dbs",
                -- archives
                "zip", "rar", "tar", "gz",
                -- misc
                "rgs", "dat", "ani", "cur", "CurtainsStyle", "CopyComplete", "lst",
            }

            local function get_ignore_patterns()
                local tbl = {}
                for _, v in ipairs(file_ignores) do
                    table.insert(tbl, "%." .. v .. "$")
                    -- table.insert(tbl, "%." .. string.upper(v) .. "$")
                end
                return tbl
            end

            fzf.setup({
                "telescope",
                winopts = {
                    -- border = {"┌", "─", "┐", "│", "┘", "─", "└" , "│" },
                    border = { "┌", " ", "┐", " ", "┘", " ", "└", " " },
                    preview = {
                        -- default = "bat",
                        border = "noborder",
                        vertical = "down:0%",
                        horizontal = "right:60%",
                    }
                },
                fzf_opts = {
                    ['--layout'] = 'reverse',
                },
                fzf_colors = {
                    ["fg"]      = { "fg", "CursorLine" },
                    ["bg"]      = { "bg", "Normal" },
                    ["hl"]      = { "fg", "Comment" },
                    ["fg+"]     = { "fg", "Normal" },
                    ["bg+"]     = { "bg", "Normal" },
                    ["hl+"]     = { "fg", "Statement" },
                    ["info"]    = { "fg", "PreProc" },
                    ["prompt"]  = { "fg", "Conditional" },
                    ["pointer"] = { "fg", "Exception" },
                    ["marker"]  = { "fg", "Keyword" },
                    ["spinner"] = { "fg", "Label" },
                    ["header"]  = { "fg", "Comment" },
                    ["gutter"]  = { "bg", "Normal" },
                },
                -- keymap = {
                --     builtin = {},
                --     fzf = {},
                -- },
                -- actions    = {
                --     files = {
                --         ["default"] = actions.file_edit_or_qf,
                --         ["ctrl-x"]  = actions.file_split,
                --         ["ctrl-v"]  = actions.file_vsplit,
                --         ["ctrl-t"]  = actions.file_tabedit,
                --         ["alt-q"]   = actions.file_sel_to_qf,
                --         ["alt-l"]   = actions.file_sel_to_ll,
                --     },
                --     buffers = {
                --         ["default"] = actions.buf_edit,
                --         ["ctrl-x"]  = actions.buf_split,
                --         ["ctrl-v"]  = actions.buf_vsplit,
                --         ["ctrl-t"]  = actions.buf_tabedit,
                --     }
                -- },
                file_ignore_patterns = get_ignore_patterns(),
                files = {
                    prompt = " ",
                    cwd_prompt = false
                },
                git = {
                    files = { prompt = " " },
                    status = { prompt = " " },
                    commits = { prompt = " " },
                    bcommits = { prompt = " " },
                    branches = { prompt = " " },
                    stash = { prompt = " " },
                },
                grep = {
                    prompt = " ",
                    input_prompt = "󰑑 ",
                },
                args = { prompt = "⌥ " },
                oldfiles = { prompt = " " },
                buffers = { prompt = "﬘ " },
                tabs = { prompt = "󰓩 " },
                lines = { prompt = " " },
                blines = { prompt = " " },
                tags = { prompt = " " },
                btags = { prompt = " " },
                colorschemes = { prompt = " " },
                keymaps = { prompt = " " },
                quickfix = { prompt = " " },
                quickfix_stack = { prompt = " " },
                lsp = {
                    prompt = "󰒋 ",
                    code_actions = { prompt = " " },
                    finder = { prompt = "﯒ " },
                },
                diagnostics = { prompt = " " }
            })

            vim.keymap.set("n", "<leader>ff", "<CMD>FzfLua files<cr>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>fr", "<CMD>FzfLua oldfiles<cr>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>fg", "<CMD>FzfLua grep_project<cr>", { noremap = true, silent = true })
        end
    },
}
