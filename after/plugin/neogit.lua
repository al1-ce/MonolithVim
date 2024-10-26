vim.api.nvim_create_user_command(
    "Git",
    function()
        require("neogit").open()
    end,
    {}
)

