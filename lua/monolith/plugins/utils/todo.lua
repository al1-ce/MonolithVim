vim.g.VimTodoListsUndoneItem = '- [ ]'
vim.g.VimTodoListsDoneItem = '- [x]'
vim.g.VimTodoListsMoveItems = 0
vim.g.VimTodoListsKeepSameIndent = 0

vim.cmd([[
function! VimTodoListsCustomMappins()
endfunction
]])
vim.g.VimTodoListsCustomKeyMapper = "VimTodoListsCustomMappins"

local keymap = vim.keymap

local function setKeymapFiletype(ft, name, mode, map, action)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = ft,
        group = vim.api.nvim_create_augroup(name, {clear = true}),
        callback = function()
            keymap.set(mode, map, action, {silent = true, buffer = true})
        end
    })
end

setKeymapFiletype('todo', 'TodoAddNew', 'n', '<CR>', '<CMD>VimTodoListsCreateNewItemBelow<CR>')
setKeymapFiletype('todo', 'TodoAddNewAbove', 'n', '<A-CR>', '<CMD>VimTodoListsCreateNewItemAbove<CR>')
setKeymapFiletype('todo', 'TodoToggle', 'n', '<Space>', '<CMD>VimTodoListsToggleItem<CR>')

-- vim.keymap.set("n", "<CR>", "<CMD>VimTodoListsNewItemBelow<CR>")
vim.cmd([[
function! VimTodoListsInitFIXED()
    setlocal tabstop=4
    setlocal shiftwidth=4 expandtab
endfunction

augroup vimtodolists_auto_commands_fixed
    autocmd!
    autocmd BufRead,BufNewFile *.todo.md call VimTodoListsInitFIXED()
    autocmd FileType todo call VimTodoListsInitFIXED()
augroup end
]])
