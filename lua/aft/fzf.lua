local fzfp         = require("plf.fzf")
local colsch       = require("lib.col")
local colorschemes = require("fzf-lua.providers.colorschemes").colorschemes

vim.api.nvim_create_user_command("FzfLuaProjects", fzfp.FzfProjects, {})

vim.api.nvim_create_user_command("Colorschemes", function()
    colorschemes({
        actions = {
            ["default"] = function(selected, opts) colsch.set(selected[1]) end
        }
    })
end, {})

