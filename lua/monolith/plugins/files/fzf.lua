-- local opts = { noremap = true, silent = true }
--
-- local keymap = vim.keymap
--
-- local function setKeymapFiletype(ft, name, mode, map, action)
--     vim.api.nvim_create_autocmd('FileType', {
--         pattern = ft,
--         group = vim.api.nvim_create_augroup(name, {clear = true}),
--         callback = function()
--             keymap.set(mode, map, action, {silent = true, buffer = true})
--         end
--     })
-- end
--
-- -- main exit hotkey
-- setKeymapFiletype('fzf', 'FZFExitI', 't', '<ESC>', '<C-c>')
--
-- -- this for backup
-- setKeymapFiletype('fzf', 'FZFExitE', 'n', '<ESC>', 'i<C-c>')
-- setKeymapFiletype('fzf', 'FZFExitQ', 'n', 'q', 'i<C-c>')
--
-- local g = vim.g
--
-- g.fzf_vim = {}
--
-- g.fzf_vim.preview_window = {"right,60%"}

local fzf = require("fzf-lua")
-- local utils = require("fzf-lua").utils
-- local actions = require("fzf-lua").actions

-- List of what I usually wouldn't need to see in fzf
local file_ignores = {
    -- images
    "png", "jpg", "jpeg", "gif", "bmp", "ico", "webp",
    "gpl", "kra", "tiff", "psd", "pdf", "dwg",
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
    for _,v in ipairs(file_ignores) do
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
        -- options are sent as `<left>=<right>`
        -- set to `false` to remove a flag
        -- set to '' for a non-value flag
        -- for raw args use `fzf_args` instead
        -- ['--ansi']   = '',
        -- ['--info']   = 'inline',
        -- ['--height'] = '100%',
        ['--layout'] = 'reverse',
        -- ['--border'] = 'none',
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
