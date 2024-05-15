require('spectre').setup({
    live_update = true,
    mapping = {
        ['send_to_qf'] = {
            map = "<leader>Q",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "send all items to quickfix"
        },
    }
})
