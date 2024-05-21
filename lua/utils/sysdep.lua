---@param deps string[]
local function sysdep(deps)
    local cond = true
    for _, val in ipairs(deps) do
        if vim.fn.executable(val) ~= 1 then
            require("utils.error")("'Failed to find " .. val .. " binary on system'")
            cond = false
        end
    end
    return cond
end

return sysdep

