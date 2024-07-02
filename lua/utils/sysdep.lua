local sysdepman = require("utils.sysdep-man")

---@param deps string[]
local function sysdep(deps)
    local cond = true
    for _, val in ipairs(deps) do
        if vim.fn.executable(val) ~= 1 then
            require("utils.error")("'Failed to find " .. val .. " binary on system'")
            sysdepman.add_dep(table.concat(deps, "\n"))
            cond = false
        end
    end
    return cond
end

return sysdep

