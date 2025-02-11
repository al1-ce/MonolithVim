local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    group = 'YankHighlight',
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
    end
})

augroup('FixColorScheme', { clear = true })
-- ColorScheme here is event
autocmd("ColorScheme", {
    group = "FixColorScheme",
    callback = function ()
        vim.cmd("PlugColorschemeSet")
    end
})

vim.cmd([[
augroup reloadfileifchanged
    autocmd!
    " trigger `autoread` when files changes on disk
    "autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
    " notification after file change
    autocmd FileChangedShellPost *
     \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END
]])

-- reopen at last edited place
augroup("LastEditGoto", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    group = "LastEditGoto",
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})

augroup("ToggleCursorLine", { clear = true })
autocmd({"WinEnter", "BufEnter"}, { group = "ToggleCursorLine", pattern = "*", command = "setlocal cursorline" })
autocmd({"WinLeave", "BufLeave"}, { group = "ToggleCursorLine", pattern = "*", command = "setlocal nocursorline" })

-- augroup("FixTerminalOpts", { clear = true })
-- autocmd({"BufWinEnter", "WinEnter", "BufEnter"},  {
--     group = "ToggleCursorLine",
--     pattern = "*",
--     -- command = "setlocal nocursorline"
--     callback = function ()
--         if vim.bo.buftype == "terminal" then
--             vim.opt.number = false
--             vim.opt.relativenumber = false
--         end
--     end
-- } )

