---@diagnostic disable: undefined-global
local can_load = require("module").can_load
local bufnoremap = require("map").bufnoremap

vim.b.wrap = true
vim.b.spell = true

if can_load("zk.util") then
    -- Add the key mappings only for Markdown files in a zk notebook.
    if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
        -- Open the link under the caret.
        bufnoremap("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Open link" })

        -- Create a new note after asking for its title.
        -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
        -- bufnoremap("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", { desc = "Create note in current dir" })
        -- Create a new note in the same directory as the current buffer, using the current selection for title.
        bufnoremap("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>",
            { desc = "[Z]k [N]ew [T]itle" })
        -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
        bufnoremap("v", "<leader>znc",
            ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
            { desc = "[Z]k [N]new from [C]ontent" })

        -- Open notes linking to the current buffer.
        bufnoremap("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", { desc = "[Z]k [B]acklinks" })
        -- Alternative for backlinks using pure LSP and showing the source context.
        -- bufnoremap('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
        -- Open notes linked by the current buffer.
        bufnoremap("n", "<leader>zl", "<Cmd>ZkLinks<CR>", { desc = "[Z]k [L]inks" })
        bufnoremap("n", "<leader>zo", "<Cmd>ZkOrphans<CR>", { desc = "[Z]k [O]phans" })

        -- Preview a linked note.
        bufnoremap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Preview linked note" })
        -- Open the code actions for a visual selection.
        bufnoremap("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", { desc = "[Z]k [A]ction" })
    end
end

-- if can_load("nvim-treesitter") then
--     bufnoremap("n", "<C-]>", '<cmd>lua require("utils.mdlinks").follow_link()<cr>', { desc = "Follow markdown link" })
-- end
