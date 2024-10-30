local sysdep  = import "utils.sysdep" .sysdep
local borders = import "var.borders"

return {
    -- FZF has priority over Telescope because Telescope often skips things
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        cond = sysdep({ "rg", "fd" }),
        config = function()
            local actions = import "telescope.actions"
            local telescope = import "telescope"

            telescope.setup({
                defaults = {
                    initial_mode = "insert",
                    file_ignore_patterns = { "node_modules", "build", "dist", "yarn.lock", ".git" },
                    path_display = { "truncate" },
                    winblend = 0,
                    border = true,
                    borderchars = borders.telescope,
                    mappings = {
                        n = { ["q"] = actions.close },
                        i = { ["<esc>"] = actions.close },
                    },
                    layout_config = { prompt_position = "top" }
                },
            })
        end
    },
}
