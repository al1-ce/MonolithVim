local template = require("pfunc.template")

vim.api.nvim_create_user_command('Template', template.paste_template, { range = false, nargs = '+', complete = template.autocomplete, })
vim.api.nvim_create_user_command('TemplateSelect', template.select, {})


