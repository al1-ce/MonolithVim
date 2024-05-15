-- Mappings
local M = {}

local opts = { noremap = true, silent = true }

-- TODO: figure out globality
M.noremap = function (mode, key, action)
    vim.keymap.set(mode, key, action, opts)
end

return M;

