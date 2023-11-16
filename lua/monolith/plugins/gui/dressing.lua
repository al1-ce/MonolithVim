require("dressing").setup({
    input = {
        enabled = true,
    },
    select = {
        enabled = true,
        backend = {
            "nui", "fzf_lua", "telescope",
            "builtin"
        }
    },
})
