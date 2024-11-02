vim.cmd([[
    "set omnifunc=ccomplete#Complete
    "so $VIMRUNTIME/autoload/ccomplete.vim
    set complete=.,w,b,u,t
    set omnifunc=syntaxcomplete#Complete

    setlocal path=.,,..,../..,./*,./*/*,../*,~/,~/**,/usr/include/*,**
]])

-- vim.api.nvim_buf_set_keymap(0, "n", "<leader>gh",  "<cmd>call Switch_To_Header_Source()<cr>",     { desc = "[G]o [H]eader",          silent = true, noremap = true })
-- vim.api.nvim_buf_set_keymap(0, "n", "<leader>gsh", "<cmd>call Switch_To_Header_Source_SP()<cr>",  { desc = "[G]o [S]plit [H]eader",  silent = true, noremap = true })
-- vim.api.nvim_buf_set_keymap(0, "n", "<leader>gvh", "<cmd>call Switch_To_Header_Source_VSP()<cr>", { desc = "[G]o [V]split [H]eader", silent = true, noremap = true })
if vim.g.distro == "despair.nvim" then
    vim.keymap.set("n", "<leader>gh",  function() __switch_c_hc("none")   end, { desc = "[G]o [H]eader",          silent = true, noremap = true, buffer = true })
    vim.keymap.set("n", "<leader>gsh", function() __switch_c_hc("split")  end, { desc = "[G]o [S]plit [H]eader",  silent = true, noremap = true, buffer = true })
    vim.keymap.set("n", "<leader>gvh", function() __switch_c_hc("vsplit") end, { desc = "[G]o [V]split [H]eader", silent = true, noremap = true, buffer = true })
end

