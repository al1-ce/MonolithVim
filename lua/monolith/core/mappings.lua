-- All primary keymaps. Some plugin-related or screen-local might be in other files
local opts = { noremap = true, silent = true }

local keymap = vim.keymap


-- All leader related keys are in lua/config/hydra.lua

-- '' - normal, visual, select, operator pending
-- n - normal
-- v - visual and select
-- s - select
-- x - visual
-- o - operator pending
-- ! - insert and command line
-- i - insert
-- l - insert, command line and lang arg
-- c - command mode
-- t - terminal

-- map to <nop> to disable

-- Goal is to slowly move away from all those "normie" shortcuts

-- -------------------------------------------------------------------------- --
--                                   Global                                   --
-- -------------------------------------------------------------------------- --

-- ---------------------------- Common shortcuts ---------------------------- --

-- quick navigation
keymap.set('n', '<Space>', '<C-d>', opts)
-- keymap.set('n', '<C-Space>', '<C-u>', opts)
keymap.set('n', '<S-Space>', '<C-u>', opts)

keymap.set('n', '<A-u>', '<C-u>', opts)
keymap.set("i", "<A-u>", "<Space>", opts)

keymap.set('n', '<PageDown>', '<C-d>', opts)
keymap.set("n", "<PageUp>", "<C-u>", opts)
keymap.set('v', '<PageDown>', '<C-d>', opts)
keymap.set("v", "<PageUp>", "<C-u>", opts)
keymap.set('i', '<PageDown>', '<Esc><C-d>i', opts)
keymap.set("i", "<PageUp>", "<Esc><C-u>i", opts)

keymap.set("", "q", "<nop>", opts)
keymap.set("", "<C-z>", "<nop>", opts)

keymap.set('n', '<C-left>', 'b', opts)
keymap.set('n', '<C-right>', 'e', opts)

-- tab navigation
keymap.set("n", "<A-.>", "<cmd>tabnext<cr>", opts)
keymap.set("n", "<A-,>", "<cmd>tabprevious<cr>", opts)

keymap.set("n", "<A-S-.>", "<cmd>tabmove +1<cr>", opts)
keymap.set("n", "<A-S-,>", "<cmd>tabmove -1<cr>", opts)

-- moving between panes
keymap.set("n", "<A-left>", "<C-w>h", opts)
keymap.set("n", "<A-down>", "<C-w>j", opts)
keymap.set("n", "<A-up>", "<C-w>k", opts)
keymap.set("n", "<A-right>", "<C-w>l", opts)

-- ctrl del
keymap.set("", "<C-Del>", '"_dw', opts);
keymap.set("i", "<C-Del>", '<C-o>"_dw', opts);

-- map delete to black hole yank
keymap.set("", "<Del>", '"_x', opts)
keymap.set("i", "<Del>", '<C-o>"_x', opts)

keymap.set('', '<S-ScrollWheelUp>', '3zh', opts)
keymap.set('', '<S-ScrollWheelDown>', '3zl', opts)
keymap.set('i', '<S-ScrollWheelUp>', '<C-o>3zh', opts)
keymap.set('i', '<S-ScrollWheelDown>', '<C-o>3zl', opts)

keymap.set('i', '<Esc>', '<Esc>l', opts);

local function lineHome()
    local x = vim.fn.col('.')
    vim.fn.execute('normal ^')
    if x == vim.fn.col('.') then
        vim.fn.execute('normal 0')
    end
end

local function lineEnd()
    local x = vim.fn.col('.')
    vim.fn.execute('normal g_')
    -- vim.fn.execute('normal! \\<Right>')
    vim.fn.execute("normal l")
    if x == vim.fn.col('.') then
        vim.fn.execute('normal g$')
    end
end

keymap.set('n', "<Home>", lineHome, opts)
keymap.set('i', "<Home>", lineHome, opts)
keymap.set('v', "<Home>", lineHome, opts)
keymap.set('n', "<End>", lineEnd, opts)
keymap.set('i', "<End>", lineEnd, opts)
keymap.set('v', "<End>", lineEnd, opts)

-- -------------------------------------------------------------------------- --
--                                 Normal Mode                                --
-- -------------------------------------------------------------------------- --

-- backspace to black hole buffer
keymap.set("n", "<BS>", '"_X', opts);

keymap.set("n", "<Tab>", ">>", opts)
keymap.set("n", "<S-Tab>", "<<", opts)
-- fix jump motion (thanks noremap)
keymap.set("n", "<C-i>", "<C-i>", opts)

keymap.set("n", "<leader>ss", "<CMD>split<CR>", opts)
keymap.set("n", "<leader>sv", "<CMD>vsplit<CR>", opts)

keymap.set("n", "<leader>fs", "<C-^>", opts)

keymap.set("n", "<leader>q", "<CMD>x<CR>", opts)
keymap.set("n", "<leader>w", "<CMD>update<CR>", opts)

local function open_link_vis()
    local key = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
    vim.fn.feedkeys('"vy', "x")
    vim.fn.feedkeys(key, "x")
    local s = vim.fn.getreg("v")
    vim.fn.execute("!open " .. '"' .. s .. '"')
    -- require("notify")(getVisualSelection())
end

local function open_link_norm()
    -- "x" makes it fast
    vim.fn.feedkeys("viW", "x")
    open_link_vis()
end

keymap.set("n", "gx", open_link_norm, opts)
keymap.set("v", "gx", open_link_vis, opts)

-- -------------------------------------------------------------------------- --
--                                 Insert Mode                                --
-- -------------------------------------------------------------------------- --

-- enter visual mode
-- why not, it does nothing so...
keymap.set("i", "<S-up>", "<C-o>v<up>", opts)
keymap.set("i", "<S-down>", "<C-o>v<down>", opts)
keymap.set("i", "<S-left>", "<C-o>v<left>", opts)
keymap.set("i", "<S-right>", "<C-o>v<right>", opts)

keymap.set("i", "<C-S-up>", "<C-o>v<C-up>", opts)
keymap.set("i", "<C-S-down>", "<C-o>v<C-down>", opts)
keymap.set("i", "<C-S-left>", "<C-o>v<C-left>", opts)
keymap.set("i", "<C-S-right>", "<C-o>v<C-right>", opts)

-- erase word
keymap.set("i", "<C-BS>", '<C-\\><C-o>"_db', opts)

-- Black magic:
keymap.set('i', '<A-S-up>', '<Esc>"myy`["mPi', opts)
keymap.set('i', '<A-S-down>', '<Esc>"myy`]"mpi', opts)

keymap.set('v', '<A-S-up>', '<S-v>"my`["mP`[V`]v', opts)
keymap.set('v', '<A-S-down>', '<S-v>"my`]"mp`[V`]v', opts)

-- erase one tab
keymap.set("i", "<S-Tab>", "<C-o><<", opts);

-- -------------------------------------------------------------------------- --
--                                 Visual Mode                                --
-- -------------------------------------------------------------------------- --

-- remap selections
keymap.set("v", "<C-S-up>", "<up>", opts)
keymap.set("v", "<C-S-down>", "<down>", opts)
keymap.set("v", "<C-S-left>", "<C-left>", opts)
keymap.set("v", "<C-S-right>", "<C-right>", opts)

keymap.set("v", "<C-up>", "<up>", opts)
keymap.set("v", "<C-down>", "<down>", opts)
keymap.set("v", "<C-left>", "<C-left>", opts)
keymap.set("v", "<C-right>", "<C-right>", opts)

keymap.set("v", "<S-up>", "<up>", opts)
keymap.set("v", "<S-down>", "<down>", opts)
keymap.set("v", "<S-left>", "<left>", opts)
keymap.set("v", "<S-right>", "<right>", opts)

-- backspace
keymap.set("v", "<BS>", '"_X', opts);

-- move tabs
keymap.set("v", "<Tab>", ">`<V`>", opts)
keymap.set("v", "<S-Tab>", "<`<V`>", opts)

-- -------------------------------------------------------------------------- --
--                                Terminal Mode                               --
-- -------------------------------------------------------------------------- --

-- Use Esc to quit builtin terminal
keymap.set("t", "<Esc>", [[<c-\><c-n>]], opts)

-- -------------------------------------------------------------------------- --
--                              Language Specific                             --
-- -------------------------------------------------------------------------- --

-- TODO: figure out how to do it with vim.api.nvim_create_augroup
vim.cmd([[au BufEnter,BufNew *.c nnoremap <silent> ;h :e %<.h<CR>]])
vim.cmd([[au BufEnter,BufNew *.h nnoremap <silent> ;h :e %<.c<CR>]])
vim.cmd([[au BufEnter,BufNew *.hpp nnoremap <silent> ;h :e %<.cpp<CR>]])
vim.cmd([[au BufEnter,BufNew *.cpp nnoremap <silent> ;h :e %<.hpp<CR>]])
