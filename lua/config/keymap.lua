-- All primary keymaps. Some plugin-related or screen-local might be in other files
local noremap = import "map" .noremap

-- tip: o switches vis direction

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
-- noremap('n', '<Space>', '<C-d>', { desc = "Jumps down by half window" })
-- noremap('n', '<S-Space>', '<C-u>', { desc = "Jumps up by half window" })

-- noremap('n', '<PageDown>', '<C-d>', { desc = "Jumps down by half window" })
-- noremap("n", "<PageUp>", "<C-u>", { desc = "Jumps up by half window" })
-- noremap('v', '<PageDown>', '<C-d>', { desc = "Jumps down by half window" })
-- noremap("v", "<PageUp>", "<C-u>", { desc = "Jumps up by half window" })
-- noremap('i', '<PageDown>', '<Esc><C-d>i', { desc = "Jumps down by half window" })
-- noremap("i", "<PageUp>", "<Esc><C-u>i", { desc = "Jumps up by half window" })

noremap('n', '<C-h>', 'b', { desc = "Goes back by word" })
noremap('n', '<C-l>', 'e', { desc = "Goes forward by word" })
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
-- noremap("", "<C-Del>", '"_dw', { desc = "Delete in word forward" });
-- noremap("i", "<C-Del>", '<C-o>"_dw', { desc = "Delete in word forward" });

local function line_len(c_row)
    return #(vim.api.nvim_buf_get_lines(0, c_row, c_row + 1, false)[1])
end

local function delete_char(is_backspace)
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local c_row = cursor_pos[1] - 1
    local c_col = cursor_pos[2]
    local row_count = vim.api.nvim_buf_line_count(0)
    local col_count = line_len(c_row)
    -- vim.notify(vim.inspect(vim.api.nvim_buf_get_lines(0, c_row, c_row + 1, false)))

    if is_backspace == 1 then
        if c_row == 0 and c_col == 0 then return end
        if c_col == 0 then
            vim.api.nvim_buf_set_text(0, c_row - 1, line_len(c_row - 1), c_row, c_col, {})
        else
            vim.api.nvim_buf_set_text(0, c_row, c_col - 1, c_row, c_col, {})
        end
    else
        if c_row == row_count - 1 and c_col == col_count then return end
        if c_col == col_count then
            vim.api.nvim_buf_set_text(0, c_row, col_count, c_row + 1, 0, {})
        else
            vim.api.nvim_buf_set_text(0, c_row, c_col, c_row, c_col + 1, {})
        end
    end
    -- bs - start higher then end
    -- dle - invalid end_col: out of range
end

noremap("n", "<Del>", function() delete_char(0) end, { desc = "Delete but into black hole" })
noremap("i", "<Del>", function() delete_char(0) end, { desc = "Delete but into black hole" })
noremap("n", "<BS>", function() delete_char(1) end, { desc = "Deletes into black hole" });
noremap("i", "<BS>", function() delete_char(1) end, { desc = "Deletes into black hole" });

noremap("n", "U", "V:s/\\s\\+/\\r/g<cr>", { desc = "Unjoin lines (don't need really linewise undo)" })

-- map delete to black hole yank
-- noremap("", "<Del>", '"_x', { desc = "Delete but into black hole" })
-- noremap("i", "<Del>", '<C-o>"_x', { desc = "Delete but into black hole" })
-- noremap("n", "<BS>", '"_X', { desc = "Deletes into black hole" });

-- FIXME: check back when https://github.com/wez/wezterm/issues/3621 fixed
-- remap("", "<C-h>", "<Del>", { desc = "Wezterm kitty protocol hotfix" })
-- remap("i", "<C-h>", "<Del>", { desc = "Wezterm kitty protocol hotfix" })
-- remap("t", "<C-h>", "<Del>", { desc = "Wezterm kitty protocol hotfix" })

noremap('', '<S-ScrollWheelUp>', '3zh', { desc = "Scrolls right" })
noremap('', '<S-ScrollWheelDown>', '3zl', { desc = "Scrolls left" })
noremap('i', '<S-ScrollWheelUp>', '<C-o>3zh', { desc = "Scrolls right" })
noremap('i', '<S-ScrollWheelDown>', '<C-o>3zl', { desc = "Scrolls left" })

noremap('i', '<Esc>', '<Esc>l', { desc = "Makes insert exit at correct spot" });

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

noremap("n", "<Tab>", ">>", { desc = "Shifts line to right" })
noremap("n", "<S-Tab>", "<<", { desc = "Shifts line to left" })
-- fix jump motion (thanks noremap)
noremap("n", "<C-i>", "<C-i>", { desc = "Jump motion fix" })

noremap("n", "<leader>ss", "<CMD>split<CR>", { desc = "[S]plit [S]horisontaly" })
noremap("n", "<leader>sv", "<CMD>vsplit<CR>", { desc = "[S]plit [V]ertically" })

noremap("n", "<leader>fs", "<C-^>", { desc = "[F]ile [S]wap" })
noremap("n", "<leader>fe", "<cmd>enew<cr>", { desc = "[F]ile [E]dit" })

noremap("n", "<leader>q", "<CMD>x<CR>", { desc = "[Q]uits buffer" })
noremap("n", "<leader>w", "<CMD>update<CR>", { desc = "[W]rites buffer" })

noremap("n", "<leader>cd", function ()
    local cdir = vim.fn.expand("%:p:h")
    vim.api.nvim_set_current_dir(cdir)
    vim.notify(vim.fn.getcwd())
end, { desc = "[C]hanges [D]irectory to current file" })

noremap("n", "<leader>ce", "<cmd>edit $MYVIMRC <bar> tcd %:h<cr>", { desc = "[C]onfig [E]dit" })

noremap("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "[T]ab [N]ew" })
noremap("n", "<leader>tw", "<cmd>tabclose<cr>", { desc = "[T]ab [C]lose" })
noremap("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "[T]ab [O]nly" })

noremap("n", "<leader>fF", vim.lsp.buf.format, { desc = "[F]ile [F]ormat" })

noremap("n", "<leader>co", "<cmd>copen<cr>", { desc = "[C][O]pen" })
noremap("n", "<leader>lo", "<cmd>lopen<cr>", { desc = "[L][O]pen" })
-- noremap("n", "<leader>lI", function ()
--     ---@diagnostic disable-next-line: missing-parameter
--     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
--     ---@diagnostic disable-next-line: missing-parameter
--     if vim.lsp.inlay_hint.is_enabled() then
--         print("Enabled inlay hint")
--     else
--         print("Disabled inlay hint")
--     end
-- end, { desc = "[L]sp [I]nlay toggle" })

noremap("n", "<leader>t1", "1gt", { desc = "Go to [t]ab [1]" })
noremap("n", "<leader>t2", "2gt", { desc = "Go to [t]ab [2]" })
noremap("n", "<leader>t3", "3gt", { desc = "Go to [t]ab [3]" })
noremap("n", "<leader>t4", "4gt", { desc = "Go to [t]ab [4]" })
noremap("n", "<leader>t5", "5gt", { desc = "Go to [t]ab [5]" })
noremap("n", "<leader>t6", "6gt", { desc = "Go to [t]ab [6]" })
noremap("n", "<leader>t7", "7gt", { desc = "Go to [t]ab [7]" })
noremap("n", "<leader>t8", "8gt", { desc = "Go to [t]ab [8]" })
noremap("n", "<leader>t9", "9gt", { desc = "Go to [t]ab [9]" })
noremap("n", "<leader>t0", "<cmd>tablast<cr>", { desc = "Go to last tab" })


local function open_link_vis()
    vim.fn.feedkeys('"vy', "x")
    vim.fn.feedkeys(vim.keycode("<esc>"), "x")
    local s = vim.fn.getreg("v")
    vim.ui.open(vim.fn.expand(s))
    vim.notify(s)
end

local function open_link_norm()
    -- "x" makes it fast
    vim.fn.feedkeys("viW", "x")
    open_link_vis()
end

noremap("n", "gx", open_link_norm, { desc = "[G]oes into link with [X]DG-OPEN" })
noremap("v", "gx", open_link_vis, { desc = "[G]oes into link with [X]DG-OPEN" })

noremap("n", "yA", "<cmd>%y<cr>", { desc = "[Y]anks [A]ll file" })

noremap("n", "n", "nzzzv", { desc = "Keep search centered" })
noremap("n", "N", "Nzzzv", { desc = "Keep search centered" })

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
-- noremap("i", "<C-BS>", '<C-\\><C-o>"_db', { desc = "Deletes word backwards" })

-- Black magic:
noremap('i', '<A-S-up>', '<Esc>"myy`["mPi', { desc = "Duplicates line up" })
noremap('i', '<A-S-down>', '<Esc>"myy`]"mpi', { desc = "Duplicates line down" })

noremap('v', '<A-S-up>', '"mY`["mP`[V`]v', { desc = "Duplicates lines up" })
noremap('v', '<A-S-down>', '"mY`]"mp`[V`]v', { desc = "Duplicates lines down" })

noremap('i', '<A-S-k>', '<Esc>"myy`["mPi', { desc = "Duplicates line up" })
noremap('i', '<A-S-j>', '<Esc>"myy`]"mpi', { desc = "Duplicates line down" })

noremap('v', '<A-S-k>', '"mY`["mP`[V`]v', { desc = "Duplicates lines up" })
noremap('v', '<A-S-j>', '"mY`]"mp`[V`]v', { desc = "Duplicates lines down" })
-- erase one tab
noremap("i", "<S-Tab>", "<C-o><<", { desc = "Shifts line left" });

noremap("v", "<S-down>", "<down>", { desc = "Prevent buffer scroll" })
noremap("v", "<S-up>", "<up>", { desc = "Prevent buffer scroll" })

noremap("n", "<leader>ST", "<cmd>TemplateSelect<cr>", { desc = "Select template with fzf and paste it under cursor" })
noremap("n", "<leader>ow", "<cmd>Wrap<cr>", { desc = "Toggle [O]ption - [W]rap" })
noremap("n", "<leader>os", "<cmd>Spell<cr>", { desc = "Toggle [O]ption - [S]pell" })
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
noremap("t", "<Esc>", [[<c-\><c-n>]], { desc = "Exits terminal insert mode" })

-- -------------------------------------------------------------------------- --
--                               Custom Execute                               --
-- -------------------------------------------------------------------------- --

noremap("n", "<leader>xb", "yy2o<ESC>kpV:!/bin/bash<CR>", { desc = "[E]xecute [B]ash and paste" })
noremap("v", "<leader>xb", "y'<P'<O<ESC>'>o<ESC>:<C-u>'<,'>!/bin/bash<CR>", { desc = "[E]xecute [B]ash and paste" })

noremap("n", "<leader>xsl", "<cmd>vsplit /tmp/nvim-scratchpad.lua<cr><cmd>w<cr>", { desc = "E[x]ecute [S]cratch [L]ua" })

-- -------------------------------------------------------------------------- --
--                               Custom Textobj                               --
-- -------------------------------------------------------------------------- --

noremap("x", "il", "g_o^", { desc = "[I]n [L]ine text object" })
noremap("x", "al", "$o^", { desc = "[A]round [L]ine text object" })
noremap("o", "il", ":norm vil<cr>", { desc = "[I]n [L]ine text object" })
noremap("o", "al", ":norm val<cr>", { desc = "[A]round [L]ine text object" })

noremap("o", "g$", ":norm vg$h<cr>", { desc = "To end of line text object" })
noremap("o", "g_", ":norm vg_h<cr>", { desc = "To last char in line text object" })
noremap("o", "^", ":norm v^<cr>", { desc = "To first char in line text object" })
noremap("o", "0", ":norm v0<cr>", { desc = "To start of line text object" })
