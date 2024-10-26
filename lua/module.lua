local M = {}

M.load = function(m)
    local ok, err = pcall(require, m)
    if not ok then
        vim.notify("Package \"" .. m .. "\" failed to load. \n\n" .. err, vim.log.levels.error)
    end
end

M.can_load = function(module)
    local ok, _   = pcall(require, module)
    if not ok then
        return false
    else
        return true
    end
end

return M
