-- autocorrects qq to Qq
vim.cmd([[cabbrev qq Qq]])

-- custom qall command
vim.api.nvim_create_user_command('Qq', function(opts) if (opts.bang) then vim.cmd [[qall!]] else vim.cmd [[qall]] end end,
    { bang = true })
vim.api.nvim_create_user_command('Spell', function() vim.o.spell = not vim.o.spell end, {})
vim.api.nvim_create_user_command('Wrap', function() vim.o.wrap = not vim.o.wrap end, {})
-- vim.api.nvim_create_user_command('FixColors', function() dofile(vim.fn.stdpath('config') .. "/lua/config/theme.lua") end, {})

local template = require("utils.template")
local noremap = require("utils.noremap")

vim.api.nvim_create_user_command('Template', template.paste_template, { range = false, nargs = '+', complete = template.autocomplete, })
vim.api.nvim_create_user_command('TemplateSelect', template.select, {})

noremap("n", "<leader>ST", template.select, { desc = "Select template with fzf and paste it under cursor" })

