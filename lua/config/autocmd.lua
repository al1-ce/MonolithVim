local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

do -- BEGIN AUTOCMD
    augroup('YankHighlight', { clear = true })
    autocmd('TextYankPost', {
        group = 'YankHighlight',
        callback = function()
            vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
        end
    })
end -- END AUTOCMD

