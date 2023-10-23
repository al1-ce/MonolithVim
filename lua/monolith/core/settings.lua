-- nvim settings

local cmd = vim.cmd             -- cmdute Vim commands
-- local cmd = vim.api.nvim_exec  -- execute Vimscript
local g = vim.g                 -- global variables
local o = vim.o                 -- global-like
local opt = vim.opt             -- global/buffer/windows-scoped options

o.signcolumn = "no"                 -- removes gutter
opt.updatetime = 300                -- speeds up autocompletion
-- g.mapleader = "\\"                  -- sets \ as leader key
g.mapleader = ";"                   -- sets , as leader key
o.clipboard = "unnamedplus"         -- set clipboard to be system
opt.cmdheight = 1                   -- cmd height

o.virtualedit = "onemore"

-- cmd [[language en_US.UTF-8]]

-- opt.colorcolumn = '120'             -- 80 symbol split
opt.cursorline = true               -- cursor line hightlight
-- opt.cursorcolumn = true             -- show cursor column
opt.number = true                   -- line numbers
-- opt.relativenumber = true           -- relative line numbers
opt.so=0                            -- cursor moves normally (no boundary)
opt.undofile = true                 -- undo
opt.splitright = true               -- vertical split right
opt.splitbelow = true               -- horizontal split down
opt.hlsearch = true                 -- Set highlight on search
opt.undofile = true                 -- Save undo history
opt.ignorecase = true               -- Case insensitive searching unless /C or capital in search
opt.wrap = false
opt.smartcase = true                -- Smart case
opt.showmatch = true                -- highlight matching brackets
opt.joinspaces = false              -- No double spaces with join after a dot

opt.termguicolors = true            -- 24-bit RGB colors
opt.showmode = false                -- no --INSERT--
o.background = "dark"               -- or "light" for light mode

cmd([[filetype indent plugin on]])
cmd([[syntax enable]])

opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 4        -- shift 4 spaces when tab
opt.tabstop = 4           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines

-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- autocorrects qq to Qq
cmd([[cabbrev qq Qq]])
-- custom qall command
vim.api.nvim_create_user_command('Qq', 
function(opts)
    if (opts.bang) then cmd[[qall!]] else cmd[[qall]] end
end,
{ nargs = "?", bang = true })

o.mouse = "nvi"             -- normal, visual, insert
o.mousemodel = "extend"     -- sets right mouse click to extend selection

o.guifont = "Cascadia Mono PL:h11"

g.ruby_host_prog = '~/.local/share/gem/ruby/3.0.0/bin/neovim-ruby-host'

cmd([[set guicursor=n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20]])

vim.g.gruvbox_contrast_dark = "medium"
vim.g.gruvbox_transparent_bg = 1
vim.g.gruvbox_baby_transparent_mode = 1

vim.cmd.colorscheme('gruvbox')

-- ----------------------------- neovide configs ---------------------------- --
-- if vim.g.neovide then
--     local alpha = function()
--       return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
--     end
--     g.neovide_transparency = 0.0
--     g.transparency = 0.8
--     g.neovide_background_color = "#262626" .. alpha()
--     g.neovide_scale_factor = 1
--     g.neovide_cursor_animation_length = 0
--     g.neovide_hide_mouse_when_typing = false
--     g.neovide_scroll_animation_length = 0.3
--     g.neovide_remember_window_size = false
--     g.neovide_remember_window_position = false
--     g.neovide_fullscreen = false
--     g.neovide_confirm_quit = true
--
--     -- g.neovide_padding_top=35
--     -- g.neovide_padding_left=28
--     -- g.neovide_padding_right=28
--     -- g.neovide_padding_bottom=10
-- end
