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
keymap.set("", "q", "<nop>", opts)
keymap.set("", "<C-z>", "<nop>", opts)

keymap.set('n', '<C-left>', 'b', opts)
keymap.set('n', '<C-right>', 'e', opts)
-- copy/paste
-- keymap.set("", "<C-c>", "\"+y", opts)
-- keymap.set("i", "<C-c>", "<nop>", opts)
-- ditto
-- keymap.set("", "<C-v>", "\"+p", opts)
-- keymap.set("i", "<C-v>", "<Esc>\"+pi<right><right>", opts)
-- undo/redo
-- keymap.set("", "<C-z>", ":undo<cr>", opts)
-- keymap.set("i", "<C-z>", "<C-o>:undo<cr>", opts)
-- -- ditto
-- keymap.set("", "<C-S-z>", ":redo<cr>", opts)
-- keymap.set("i", "<C-S-z>", "<C-o>:redo<cr>", opts)
-- select all
-- keymap.set("", "<C-a>", "ggVG", opts)
-- keymap.set("i", "<C-a>", "<C-o>ggVG", opts)
-- save
-- keymap.set("", "<C-s>", ":w<cr>", opts)
-- keymap.set("i", "<C-s>", "<C-o>:w<cr>", opts)
-- search match
-- keymap.set("", "<C-f>", "/", opts)
-- keymap.set("", "<C-S-f>", ":CtrlSF ", opts)

-- keymap.set("", "<S-u>", "<C-r>", opts)
-- keymap.set("", "<C-r>", ":%s//R/g<left><left><left><left>")

-- see barbar
-- new tab
-- keymap.set("n", "<C-t>", ":$tabnew<cr>", opts)
-- close tab
-- keymap.set("n", "<C-w>", ":tabclose<cr>", opts)
-- tab navigation
keymap.set("n", "<A-.>", ":tabnext<cr>", opts)
keymap.set("n", "<A-,>", ":tabprevious<cr>", opts)

keymap.set("n", "<A-S-.>", ":tabmove +1<cr>", opts)
keymap.set("n", "<A-S-,>", ":tabmove -1<cr>", opts)

-- moving between panes
keymap.set("n", "<A-left>", "<C-w>h", opts)
keymap.set("n", "<A-down>", "<C-w>j", opts)
keymap.set("n", "<A-up>", "<C-w>k", opts)
keymap.set("n", "<A-right>", "<C-w>l", opts)
-- resizing panes
keymap.set("n", "<A-C-left>", function() require('smart-splits').resize_left(2) end, opts)
keymap.set("n", "<A-C-down>", function() require('smart-splits').resize_down(2) end, opts)
keymap.set("n", "<A-C-up>", function() require('smart-splits').resize_up(2) end, opts)
keymap.set("n", "<A-C-right>", function() require('smart-splits').resize_right(2) end, opts)
-- moving panes
keymap.set("n", "<A-S-left>", "<cmd>WinShift left<cr>", opts)
keymap.set("n", "<A-S-down>", "<cmd>WinShift down<cr>", opts)
keymap.set("n", "<A-S-up>", "<cmd>WinShift up<cr>", opts)
keymap.set("n", "<A-S-right>", "<cmd>WinShift right<cr>", opts)

-- ctrl del
keymap.set("", "<C-Del>", '"_dw', opts);
keymap.set("i", "<C-Del>", '<C-o>"_dw', opts);

keymap.set('', '<S-ScrollWheelUp>', '3zh', opts)
keymap.set('', '<S-ScrollWheelDown>', '3zl', opts)
keymap.set('i', '<S-ScrollWheelUp>', '<C-o>3zh', opts)
keymap.set('i', '<S-ScrollWheelDown>', '<C-o>3zl', opts)

keymap.set('i', '<Esc>', '<Esc>l', opts);

function lineHome()
    local x = vim.fn.col('.')
    vim.fn.execute('normal ^')
    if x == vim.fn.col('.') then
        vim.fn.execute('normal 0')
    end
end

function lineEnd()
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

-- allow to go into visual block
-- keymap.set("n", "<A-v>", "<C-v>", opts);

-- -------------------------------- IDE Like -------------------------------- --

-- open file/folder
-- keymap.set("n", "<C-S-o>", "<cmd>Telescope opener<cr>", opts)
-- keymap.set("n", "<C-A-p>", "<cmd>FzfLua tabs<cr>", opts)
-- keymap.set("n", "<C-o>", ":e ", opts)
-- keymap.set("n", "<C-S-o>", ":e ", opts)

-- nop
keymap.set("n", "<C-i>", "i<Right>_<Esc>r", opts)
keymap.set("n", "<Tab>", "<nop>", opts)

keymap.set("n", "<Tab>", ">>", opts)
keymap.set("n", "<S-Tab>", "<<", opts)

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
-- normal, yank, up, paste above, insert
keymap.set('i', '<A-up>', '<Esc>"mddk"mPi', opts)
-- normal, yank, down, paste above, insert
keymap.set('i', '<A-down>', '<Esc>"mddj"mPi', opts)

-- normal, yank, paste above, paste above, insert
keymap.set('i', '<A-S-up>', '<Esc>"mdd"mP"mPi', opts)
-- normal, yank, paste above, down, paste above, insert
keymap.set('i', '<A-S-down>', '<Esc>"mdd"mPj"mPi', opts)

-- visline, cut, up, paste above, select range, visual
keymap.set('v', '<A-up>', '<S-v>"mxk"mP`[V`]v', opts)
-- visline, cut, paste at, select range, visual
keymap.set('v', '<A-down>', '<S-v>"mx"mp`[V`]v', opts)

-- visline, cut, up, paste at, paste above, select, visual
keymap.set('v', '<A-S-up>', '<S-v>"mxk"mp"mP`[V`]v', opts)
-- visline, cut, paste above, select end, paste at, select, visual
keymap.set('v', '<A-S-down>', '<S-v>"mx"mP`]"mp`[V`]v', opts)

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

-- keymap.set("v", "<up>", "<Esc><up>", opts)
-- keymap.set("v", "<down>", "<Esc><down>", opts)
-- keymap.set("v", "<left>", "<Esc><left>", opts)
-- keymap.set("v", "<right>", "<Esc><right>", opts)

-- backspace
keymap.set("v", "<BS>", '"_X', opts);

-- move tabs
keymap.set("v", "<Tab>", ">`<V`>", opts)
keymap.set("v", "<S-Tab>", "<`<V`>", opts)

-- -------------------------------------------------------------------------- --
--                                Termianl Mode                               --
-- -------------------------------------------------------------------------- --

-- Use Esc to quit builtin terminal
keymap.set("t", "<Esc>", [[<c-\><c-n>]], opts)

-- map delete to black hole yank
keymap.set("", "<Del>", '"_x', opts)
keymap.set("i", "<Del>", '<C-o>"_x', opts)

-- -------------------------------------------------------------------------- --
--                                   PLugins                                  --
-- -------------------------------------------------------------------------- --

-- ------------------------- search with word start ------------------------- --
keymap.set("n", "S", "<Plug>(easymotion-overwin-f)", opts)
keymap.set("n", "s", "<Plug>(easymotion-overwin-f2)", opts)

-- -------------------------------- other ----------------------------------- --
keymap.set("n", "<C-`>", require('nvim-toggler').toggle)

-- -------------------------------- comments -------------------------------- --
local commentApi = require("Comment.api")
local commentEsc = vim.api.nvim_replace_termcodes(
    '<ESC>', true, false, true
)
keymap.set("v", "<C-/>", function()
    vim.api.nvim_feedkeys(commentEsc, 'nx', false)
    commentApi.toggle.linewise(vim.fn.visualmode())
end);
keymap.set("v", "<C-S-/>", function()
    vim.api.nvim_feedkeys(commentEsc, 'nx', false)
    commentApi.toggle.blockwise(vim.fn.visualmode())
end);
keymap.set("n", "<C-/>", commentApi.toggle.linewise.current, opts);
keymap.set("i", "<C-/>", commentApi.toggle.linewise.current, opts);

keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
keymap.set("n", "gK", "<cmd>Lspsaga peek_definition<cr>", opts)

keymap.set("n", "<A-s>", "<cmd>Lspsaga hover_doc<cr>", opts)
keymap.set("i", "<A-s>", "<cmd>Lspsaga hover_doc<cr>", opts)
keymap.set("n", "<A-d>", "<cmd>Lspsaga peek_definition<cr>", opts)
keymap.set("i", "<A-d>", "<cmd>Lspsaga peek_definition<cr>", opts)
keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts)

for _, key in ipairs({ 'n', 'N', '*', '#' }) do
    vim.keymap.set(
        'n',
        key,
        key ..
        '<Cmd>lua MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>'
    )
end

keymap.set('v', 'ga', '<Plug>(EasyAlign)', opts)
keymap.set('n', 'ga', '<Plug>(EasyAlign)', opts)

-- ----------------------------------- Helpers ------------------------------ --

local function setKeymapFiletype(ft, name, mode, map, action)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = ft,
        group = vim.api.nvim_create_augroup(name, {clear = true}),
        callback = function()
            keymap.set(mode, map, action, {silent = true, buffer = true})
        end
    })
end

setKeymapFiletype('NvimTree', 'NvimTree_Help', 'n', '?', '<cmd>h nvim-tree-default-mappings<cr>')


