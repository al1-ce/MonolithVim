-- monolith.nvim-only keymaps
local noremap = require("map").noremap

noremap("n", "<leader>lf", vim.lsp.buf.format, { desc = "[L]sp [F]ormat" })
noremap("n", "<leader>ST", "<cmd>TemplateSelect<cr>", { desc = "Select template with fzf and paste it under cursor" })


