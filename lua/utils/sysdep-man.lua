local M = {}

local deps = ""
local opts = ""

M.add_dep = function (dep)
    deps = deps .. "\n" .. dep
end

M.add_opt = function (dep)
    opts = opts .. "\n" .. dep
end

M.init_command = function ()
    vim.api.nvim_create_user_command("DepsMissing", function ()
        if deps ~= "" then vim.notify("Missing required dependencies:\n" .. deps) end
        if opts ~= "" then vim.notify("Missing optional dependencies:\n" .. opts) end
    end, {})
end

return M
