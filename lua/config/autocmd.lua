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
autocmd("ColorScheme", {
    group = "FixColorScheme",
    callback = function ()
    dofile(vim.fn.stdpath('config') .. "/lua/config/theme.lua")
end
})

vim.cmd([[
augroup reloadfileifchanged
    autocmd!
    " trigger `autoread` when files changes on disk
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
    " notification after file change
    autocmd FileChangedShellPost *
     \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END
]])

