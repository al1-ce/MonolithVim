local M = {}

local deps = ""
local opts = ""
local is_setup = false

M.add_dep = function (dep)
    deps = deps .. "\n" .. dep
end

M.add_opt = function (dep)
    opts = opts .. "\n" .. dep
end

---@param _deps string[]
M.sysdep = function (_deps)
    local cond = true
    for _, val in ipairs(_deps) do
        if vim.fn.executable(val) ~= 1 then
            require("lib.err")("'Failed to find " .. val .. " binary on system'")
            -- sysdepman.add_dep(table.concat(deps, "\n"))
            M.add_dep(val .. "\n")
            cond = false
        end
    end
    return cond
end

---@param _deps string[]
M.optdep = function (_deps)
    local cond = true
    for _, val in ipairs(_deps) do
        if vim.fn.executable(val) ~= 1 then
            -- require("lib.err")("'Failed to find " .. val .. " binary on system'")
            M.add_opt(val .. "\n")
            cond = false
        end
    end
    return cond
end

if is_setup == false then
    vim.api.nvim_create_user_command("DepsMissing", function ()
        if deps ~= "" then vim.notify("Missing required dependencies:\n" .. deps) end
        if opts ~= "" then vim.notify("Missing optional dependencies:\n" .. opts) end
    end, {})
end

return M


