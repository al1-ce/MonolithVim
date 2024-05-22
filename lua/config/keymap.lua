-- All primary keymaps. Some plugin-related or screen-local might be in other files
local noremap = require("utils.noremap")
local remap = require("utils.remap")


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
noremap('n', '<Space>', '<C-d>', { desc = "Jumps down by half window" })
noremap('n', '<S-Space>', '<C-u>', { desc = "Jumps up by half window" })

noremap('n', '<PageDown>', '<C-d>', { desc = "Jumps down by half window" })
noremap("n", "<PageUp>", "<C-u>", { desc = "Jumps up by half window" })
noremap('v', '<PageDown>', '<C-d>', { desc = "Jumps down by half window" })
noremap("v", "<PageUp>", "<C-u>", { desc = "Jumps up by half window" })
noremap('i', '<PageDown>', '<Esc><C-d>i', { desc = "Jumps down by half window" })
noremap("i", "<PageUp>", "<Esc><C-u>i", { desc = "Jumps up by half window" })

noremap('n', '<C-left>', 'b', { desc = "Goes back by word" })
noremap('n', '<C-right>', 'e', { desc = "Goes forward by word" })

-- tab navigation
noremap("n", "<A-.>", "<cmd>tabnext<cr>", { desc = "Opens next tab" })
noremap("n", "<A-,>", "<cmd>tabprevious<cr>", { desc = "Opens previous tab" })

noremap("n", "<A-S-.>", "<cmd>tabmove +1<cr>", { desc = "Moves tab right" })
noremap("n", "<A-S-,>", "<cmd>tabmove -1<cr>", { desc = "Moves tab left" })

-- moving between panes
noremap("n", "<A-h>", "<C-w>h", { desc = "Focuses pane to the left" })
noremap("n", "<A-l>", "<C-w>l", { desc = "Focuses pane to the right" })
noremap("n", "<A-k>", "<C-w>k", { desc = "Focuses upper pane" })
noremap("n", "<A-j>", "<C-w>j", { desc = "Focuses lower pane" })
noremap("n", "<A-left>", "<C-w>h", { desc = "Focuses pane to the left" })
noremap("n", "<A-right>", "<C-w>l", { desc = "Focuses pane to the right" })
noremap("n", "<A-up>", "<C-w>k", { desc = "Focuses upper pane" })
noremap("n", "<A-down>", "<C-w>j", { desc = "Focuses lower pane" })

-- ctrl del
noremap("", "<C-Del>", '"_dw', { desc = "Delete in word forward" });
noremap("i", "<C-Del>", '<C-o>"_dw', { desc = "Delete in word forward" });

-- map delete to black hole yank
noremap("", "<Del>", '"_x', { desc = "Delete but into black hole" })
noremap("i", "<Del>", '<C-o>"_x', { desc = "Delete but into black hole" })
-- FIXME: check back when https://github.com/wez/wezterm/issues/3621 fixed
remap("", "<C-h>", "<Del>", { desc = "Wezterm kitty protocol hotfix" })
remap("i", "<C-h>", "<Del>", { desc = "Wezterm kitty protocol hotfix" })

noremap('', '<S-ScrollWheelUp>', '3zh', { desc = "Scrolls right" })
noremap('', '<S-ScrollWheelDown>', '3zl', { desc = "Scrolls left" })
noremap('i', '<S-ScrollWheelUp>', '<C-o>3zh', { desc = "Scrolls right" })
noremap('i', '<S-ScrollWheelDown>', '<C-o>3zl', { desc = "Scrolls left" })

noremap('i', '<Esc>', '<Esc>l', { desc = "" });

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

noremap('n', "<Home>", lineHome, { desc = "Goes to beginning of line" })
noremap('i', "<Home>", lineHome, { desc = "Goes to beginning of line" })
noremap('v', "<Home>", lineHome, { desc = "Goes to beginning of line" })
noremap('n', "<End>", lineEnd, { desc = "Goes to end of line" })
noremap('i', "<End>", lineEnd, { desc = "Goes to end of line" })
noremap('v', "<End>", lineEnd, { desc = "Goes to end of line" })

-- -------------------------------------------------------------------------- --
--                                 Normal Mode                                --
-- -------------------------------------------------------------------------- --

-- backspace to black hole buffer
noremap("n", "<BS>", '"_X', { desc = "Delete in word backwards" });

noremap("n", "<Tab>", ">>", { desc = "Shifts line to right" })
noremap("n", "<S-Tab>", "<<", { desc = "Shifts line to left" })
-- fix jump motion (thanks noremap)
noremap("n", "<C-i>", "<C-i>", { desc = "Jump motion fix" })

noremap("n", "<leader>ss", "<CMD>split<CR>", { desc = "Opens horizontal split" })
noremap("n", "<leader>sv", "<CMD>vsplit<CR>", { desc = "Opens vertical split" })

noremap("n", "<leader>fs", "<C-^>", { desc = "Opens previous buffer" })
noremap("n", "<leader>fe", "<cmd>enew<cr>", { desc = "Creates new file" })

noremap("n", "<leader>q", "<CMD>x<CR>", { desc = "Closes buffer" })
noremap("n", "<leader>w", "<CMD>update<CR>", { desc = "Writes buffer" })

noremap("n", "<leader>cd", "<cmd>cd %:h<cr>", { desc = "Changes directory to current file" })
noremap("n", "<leader>ce", "<cmd>edit $MYVIMRC <bar> tcd %:h<cr>", { desc = "Edits config" })

noremap("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Creates new tab" })
noremap("n", "<leader>tw", "<cmd>tabclose<cr>", { desc = "Closes current tab" })
noremap("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Closes other tabs" })

noremap("n", "<leader>fF", vim.lsp.buf.format, { desc = "Formats current buffer" })


local function open_link_vis()
    local key = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
    vim.fn.feedkeys('"vy', "x")
    vim.fn.feedkeys(key, "x")
    local s = vim.fn.getreg("v")
    local async = require("plenary.job")
    local job = async:new({
        command = "xdg-open",
        args = {vim.fn.expand(s)},
        cwd = vim.fn.getcwd()
    })
    job:start()
    -- vim.fn.execute("silent !open " .. '"' .. vim.fn.expand(s) .. '"')
    require("notify")(s)
end

local function open_link_norm()
    -- "x" makes it fast
    vim.fn.feedkeys("viW", "x")
    open_link_vis()
end

noremap("n", "gx", open_link_norm, { desc = "Sends link under cursor into XDG-OPEN" })
noremap("v", "gx", open_link_vis, { desc = "Sends link under cursor into XDG-OPEN" })

noremap("n", "ya", "<cmd>%y<cr>", { desc = "Yanks entire file" })

-- -------------------------------------------------------------------------- --
--                                 Insert Mode                                --
-- -------------------------------------------------------------------------- --

-- enter visual mode
-- why not, it does nothing so...
noremap("i", "<S-up>", "<C-o>v<up>", { desc = "Selects text in visual mode" })
noremap("i", "<S-down>", "<C-o>v<down>", { desc = "Selects text in visual mode" })
noremap("i", "<S-left>", "<C-o>v<left>", { desc = "Selects text in visual mode" })
noremap("i", "<S-right>", "<C-o>v<right>", { desc = "Selects text in visual mode" })

noremap("i", "<C-S-up>", "<C-o>v<C-up>", { desc = "Selects text in visual mode" })
noremap("i", "<C-S-down>", "<C-o>v<C-down>", { desc = "Selects text in visual mode" })
noremap("i", "<C-S-left>", "<C-o>v<C-left>", { desc = "Selects text in visual mode" })
noremap("i", "<C-S-right>", "<C-o>v<C-right>", { desc = "Selects text in visual mode" })

-- erase word
noremap("i", "<C-BS>", '<C-\\><C-o>"_db', { desc = "Deletes word backwards" })

-- Black magic:
noremap('i', '<A-S-up>', '<Esc>"myy`["mPi', { desc = "Duplicates line up" })
noremap('i', '<A-S-down>', '<Esc>"myy`]"mpi', { desc = "Duplicates line down" })

noremap('v', '<A-S-up>', '<S-v>"my`["mP`[V`]v', { desc = "Duplicates lines up" })
noremap('v', '<A-S-down>', '<S-v>"my`]"mp`[V`]v', { desc = "Duplicates lines down" })

-- erase one tab
noremap("i", "<S-Tab>", "<C-o><<", { desc = "Shifts line left" });

-- -------------------------------------------------------------------------- --
--                                 Visual Mode                                --
-- -------------------------------------------------------------------------- --

-- backspace
noremap("v", "<BS>", '"_X', { desc = "Deletes into black hole" });

-- move tabs
noremap("v", "<Tab>", ">`<V`>", { desc = "Shifts lines right" })
noremap("v", "<S-Tab>", "<`<V`>", { desc = "Shifts lines left" })

-- -------------------------------------------------------------------------- --
--                                Terminal Mode                               --
-- -------------------------------------------------------------------------- --

-- Use Esc to quit builtin terminal
noremap("t", "<Esc>", [[<c-\><c-n>]], { desc = "Closes builtin terminal" })

