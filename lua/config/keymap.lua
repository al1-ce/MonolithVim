local noremap = require("map").noremap
local keyfunc
if vim.g.vim_distro == "monolith.nvim" then
    keyfunc = require("config.keyfunc")
else
    keyfunc = require("keyfunc")
end

-- - ----------------------------------------------------------------------------- -
-- -                       Window navigation and management                        -
-- - ----------------------------------------------------------------------------- -

noremap("n", "<A-h>",     "<C-w>h", { desc = "Focuses pane to the left" })
noremap("n", "<A-l>",     "<C-w>l", { desc = "Focuses pane to the right" })
noremap("n", "<A-k>",     "<C-w>k", { desc = "Focuses upper pane" })
noremap("n", "<A-j>",     "<C-w>j", { desc = "Focuses lower pane" })
noremap("n", "<A-left>",  "<C-w>h", { desc = "Focuses pane to the left" })
noremap("n", "<A-right>", "<C-w>l", { desc = "Focuses pane to the right" })
noremap("n", "<A-up>",    "<C-w>k", { desc = "Focuses upper pane" })
noremap("n", "<A-down>",  "<C-w>j", { desc = "Focuses lower pane" })

noremap("n", "<leader>ss", "<CMD>split<CR>", { desc = "[S]plit [S]horisontaly" })
noremap("n", "<leader>sv", "<CMD>vsplit<CR>", { desc = "[S]plit [V]ertically" })


-- - ----------------------------------------------------------------------------- -
-- -                                    Scroll                                     -
-- - ----------------------------------------------------------------------------- -

noremap('' , '<S-ScrollWheelUp>',   '3zh', { desc = "Scrolls right" })
noremap('' , '<S-ScrollWheelDown>', '3zl', { desc = "Scrolls left" })
noremap('i', '<S-ScrollWheelUp>',   '<C-o>3zh', { desc = "Scrolls right" })
noremap('i', '<S-ScrollWheelDown>', '<C-o>3zl', { desc = "Scrolls left" })

-- - ----------------------------------------------------------------------------- -
-- -                                     Misc                                      -
-- - ----------------------------------------------------------------------------- -

noremap('i', '<Esc>', '<Esc>l', { desc = "Makes insert exit at correct spot" });
noremap("n", "<C-i>", "<C-i>",  { desc = "Jump motion fix" })
noremap("n", "U", "V:s/\\s\\+/\\r/g<cr>", { desc = "Unjoin lines (don't need really linewise undo)" })

-- - ----------------------------------------------------------------------------- -
-- -                               Buffer navigation                               -
-- - ----------------------------------------------------------------------------- -

noremap('n', "<Home>", keyfunc.lineHome, { desc = "Goes to beginning of line" })
noremap('i', "<Home>", keyfunc.lineHome, { desc = "Goes to beginning of line" })
noremap('v', "<Home>", keyfunc.lineHome, { desc = "Goes to beginning of line" })
noremap('n', "<End>",  keyfunc.lineEnd,  { desc = "Goes to end of line" })
noremap('i', "<End>",  keyfunc.lineEnd,  { desc = "Goes to end of line" })
noremap('v', "<End>",  keyfunc.lineEnd,  { desc = "Goes to end of line" })

noremap("n", "n", "nzzzv", { desc = "Keep search centered" })
noremap("n", "N", "Nzzzv", { desc = "Keep search centered" })

-- - ----------------------------------------------------------------------------- -
-- -                                 Text editing                                  -
-- - ----------------------------------------------------------------------------- -

noremap("n", "<Tab>",   ">>", { desc = "Shifts line to right" })
noremap("n", "<S-Tab>", "<<", { desc = "Shifts line to left" })

noremap("v", "<Tab>",   ">`<V`>", { desc = "Shifts lines right" })
noremap("v", "<S-Tab>", "<`<V`>", { desc = "Shifts lines left" })

noremap("n", "yA", "<cmd>%y<cr>", { desc = "[Y]anks [A]ll file" })

noremap('i', '<A-S-up>',   '<Esc>"myy`["mPi', { desc = "Duplicates line up" })
noremap('i', '<A-S-down>', '<Esc>"myy`]"mpi', { desc = "Duplicates line down" })

noremap('v', '<A-S-up>',   '"mY`["mP`[V`]v', { desc = "Duplicates lines up" })
noremap('v', '<A-S-down>', '"mY`]"mp`[V`]v', { desc = "Duplicates lines down" })

noremap('i', '<A-S-k>', '<Esc>"myy`["mPi', { desc = "Duplicates line up" })
noremap('i', '<A-S-j>', '<Esc>"myy`]"mpi', { desc = "Duplicates line down" })

noremap('v', '<A-S-k>', '"mY`["mP`[V`]v', { desc = "Duplicates lines up" })
noremap('v', '<A-S-j>', '"mY`]"mp`[V`]v', { desc = "Duplicates lines down" })

noremap("i", "<S-Tab>", "<C-o><<", { desc = "Shifts line left" });

noremap("n", "<Del>", function() keyfunc.delete_char(0) end, { desc = "Delete but into black hole" })
noremap("i", "<Del>", function() keyfunc.delete_char(0) end, { desc = "Delete but into black hole" })
noremap("n", "<BS>",  function() keyfunc.delete_char(1) end, { desc = "Deletes into black hole" });
noremap("i", "<BS>",  function() keyfunc.delete_char(1) end, { desc = "Deletes into black hole" });
noremap("v", "<BS>", '"_X', { desc = "Deletes into black hole" });

-- - ----------------------------------------------------------------------------- -
-- -                               Buffer management                               -
-- - ----------------------------------------------------------------------------- -

noremap("n", "<leader>fs", "<C-^>",          { desc = "[F]ile [S]wap" })
noremap("n", "<leader>fe", "<cmd>enew<cr>",  { desc = "[F]ile [E]dit" })
noremap("n", "<leader>q", "<CMD>x<CR>",      { desc = "[Q]uits buffer" })
noremap("n", "<leader>w", "<CMD>update<CR>", { desc = "[W]rites buffer" })

-- - ----------------------------------------------------------------------------- -
-- -                               Quick navigation                                -
-- - ----------------------------------------------------------------------------- -

noremap("n", "<leader>cd", keyfunc.cd_filedir, { desc = "[C]hanges [D]irectory to current file" })
noremap("n", "<leader>ce", "<cmd>edit $MYVIMRC <bar> tcd %:h<cr>", { desc = "[C]onfig [E]dit" })

-- - ----------------------------------------------------------------------------- -
-- -                                  Programming                                  -
-- - ----------------------------------------------------------------------------- -

noremap("n", "<leader>co", "<cmd>copen<cr>", { desc = "[C][O]pen" })
noremap("n", "<leader>lo", "<cmd>lopen<cr>", { desc = "[L][O]pen" })

-- - ----------------------------------------------------------------------------- -
-- -                                   Remapping                                   -
-- - ----------------------------------------------------------------------------- -

noremap("n", "gx", keyfunc.open_link_norm, { desc = "[G]oes into link with [X]DG-OPEN" })
noremap("v", "gx", keyfunc.open_link_vis,  { desc = "[G]oes into link with [X]DG-OPEN" })

-- - ----------------------------------------------------------------------------- -
-- -                                  Empty" maps                                  -
-- - ----------------------------------------------------------------------------- -

noremap("i", "<S-up>",    "<C-o>v<up>",    { desc = "Selects text in visual mode" })
noremap("i", "<S-down>",  "<C-o>v<down>",  { desc = "Selects text in visual mode" })
noremap("i", "<S-left>",  "<C-o>v<left>",  { desc = "Selects text in visual mode" })
noremap("i", "<S-right>", "<C-o>v<right>", { desc = "Selects text in visual mode" })

noremap("i", "<C-S-up>",    "<C-o>v<C-up>",    { desc = "Selects text in visual mode" })
noremap("i", "<C-S-down>",  "<C-o>v<C-down>",  { desc = "Selects text in visual mode" })
noremap("i", "<C-S-left>",  "<C-o>v<C-left>",  { desc = "Selects text in visual mode" })
noremap("i", "<C-S-right>", "<C-o>v<C-right>", { desc = "Selects text in visual mode" })

noremap("v", "<S-down>", "<down>", { desc = "Prevent buffer scroll" })
noremap("v", "<S-up>",   "<up>",   { desc = "Prevent buffer scroll" })

-- - ----------------------------------------------------------------------------- -
-- -                                 Quick config                                  -
-- - ----------------------------------------------------------------------------- -

noremap("n", "<leader>ow", "<cmd>Wrap<cr>",  { desc = "Toggle [O]ption - [W]rap" })
noremap("n", "<leader>os", "<cmd>Spell<cr>", { desc = "Toggle [O]ption - [S]pell" })

-- - ----------------------------------------------------------------------------- -
-- -                                   Terminal                                    -
-- - ----------------------------------------------------------------------------- -

noremap("t", "<Esc>", [[<c-\><c-n>]], { desc = "Exits terminal insert mode" })

-- - ----------------------------------------------------------------------------- -
-- -                                Code execution                                 -
-- - ----------------------------------------------------------------------------- -

noremap("n", "<leader>xb", "yy2o<ESC>kpV:!/bin/bash<CR>", { desc = "[E]xecute [B]ash and paste" })
noremap("v", "<leader>xb", "y'<P'<O<ESC>'>o<ESC>:<C-u>'<,'>!/bin/bash<CR>", { desc = "[E]xecute [B]ash and paste" })
noremap("n", "<leader>xsl", "<cmd>vsplit /tmp/nvim-scratchpad.lua<cr><cmd>w<cr>", { desc = "E[x]ecute [S]cratch [L]ua" })

-- - ----------------------------------------------------------------------------- -
-- -                                  Textobjects                                  -
-- - ----------------------------------------------------------------------------- -

noremap("x", "il", "g_o^", { desc = "[I]n [L]ine text object" })
noremap("x", "al", "$o^",  { desc = "[A]round [L]ine text object" })
noremap("o", "il", ":norm vil<cr>", { desc = "[I]n [L]ine text object" })
noremap("o", "al", ":norm val<cr>", { desc = "[A]round [L]ine text object" })

noremap("o", "g$", ":norm vg$h<cr>", { desc = "To end of line text object" })
noremap("o", "g_", ":norm vg_h<cr>", { desc = "To last char in line text object" })
noremap("o", "^",  ":norm v^<cr>",   { desc = "To first char in line text object" })
noremap("o", "0",  ":norm v0<cr>",   { desc = "To start of line text object" })

-- - ----------------------------------------------------------------------------- -
-- -                                 Diff editing                                  -
-- - ----------------------------------------------------------------------------- -

noremap("n", "<leader>df", "/=======<cr><cmd>nohl<cr>", { desc = "[D]iff [F]ind" })
noremap("n", "<leader>dF", "?=======<cr><cmd>nohl<cr>", { desc = "[D]iff [F]ind backwards" })
noremap("n", "<leader>di", "mf/>>>>>>> <cr>mt?<<<<<<< <cr>mk'fV'tx'kdd<cmd>nohl<cr>", { desc = "[D]iff [I]ncomming" })
noremap("n", "<leader>do", "mf?<<<<<<< <cr>mt/>>>>>>> <cr>mk'fV'tx'kdd<cmd>nohl<cr>", { desc = "[D]iff [O]utgoing" })
noremap("n", "<leader>db", "dd?<<<<<<< <cr>dd/>>>>>>> <cr>dd<cmd>nohl<cr>", { desc = "[D]iff [K]eep both" })

-- - ----------------------------------------------------------------------------- -
-- -                                Tab navigation                                 -
-- - ----------------------------------------------------------------------------- -

noremap("n", "<A-.>", "<cmd>tabnext<cr>",     { desc = "Opens next tab" })
noremap("n", "<A-,>", "<cmd>tabprevious<cr>", { desc = "Opens previous tab" })

noremap("n", "<A-S-.>", "<cmd>tabmove +1<cr>", { desc = "Moves tab right" })
noremap("n", "<A-S-,>", "<cmd>tabmove -1<cr>", { desc = "Moves tab left" })

noremap("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "[T]ab [N]ew" })
noremap("n", "<leader>tw", "<cmd>tabclose<cr>", { desc = "[T]ab [C]lose" })
noremap("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "[T]ab [O]nly" })

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

-- - ----------------------------------------------------------------------------- -
-- -                                Tips and notes                                 -
-- - ----------------------------------------------------------------------------- -

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


