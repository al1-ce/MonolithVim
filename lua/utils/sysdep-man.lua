local M = {}

local deps = ""

M.add_dep = function (dep)
    deps = deps .. "\n" .. dep
end

M.init_command = function ()
    vim.api.nvim_create_user_command("GetMissingDeps", function ()
        vim.notify("Missing dependencies:\n" .. deps)
    end, {})
end

return M
