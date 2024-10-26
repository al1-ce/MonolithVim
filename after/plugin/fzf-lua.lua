local fzf_util = require("utils.fzf")
vim.api.nvim_create_user_command("FzfLuaProjects", fzf_util.FzfProjects, {})

vim.api.nvim_create_user_command("Colorschemes", function()
    require("fzf-lua.providers.colorschemes").colorschemes({
        actions = {
            ["default"] = fzf_util.set_colorscheme
        }
    })
end, {})

