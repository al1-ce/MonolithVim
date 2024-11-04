---@diagnostic disable: undefined-field
---@diagnostic disable: param-type-mismatch
local M = { on_reload_listeners = {} }

local is_setup = false

M.on_reload = function(func) table.insert(M.on_reload_listeners, func) end

M.source = function()
    local config_loc = vim.fn.fnamemodify(vim.fn.expand("$HOME"), ":p:h") .. "/.config/neovim-theme.lua"
    local f = io.open(config_loc, "r")
    if f ~= nil then
        io.close(f)
        vim.cmd("source " .. config_loc)
    end
end

M.set = function(name)
    -- print(vim.inspect(name))

    -- TODO: apply also to lualine
    local colorscheme = name:match("^[^:]+")
    pcall(function() vim.cmd("colorscheme " .. colorscheme) end)

    for _, f in ipairs(M.on_reload_listeners) do
        pcall(f)
        print(vim.inspect(f))
    end

    local config_loc = vim.fn.fnamemodify(vim.fn.expand("$HOME"), ":p:h") .. "/.config/neovim-theme.lua"
    vim.loop.fs_open(config_loc, "w", 432, function(err, fd)
        vim.loop.fs_write(fd, "vim.cmd.colorscheme('" .. name .. "')", nil, function()
            vim.loop.fs_close(fd)
        end)
    end)
end

if not is_setup then M.source(); is_setup = true end

return M


