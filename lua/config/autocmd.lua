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

    autocmd("ColorScheme", { callback = function ()
        require("config.theme")
    end })
end -- END AUTOCMD

