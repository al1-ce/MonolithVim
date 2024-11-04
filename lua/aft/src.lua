local list_dir = require("lib.pth").list_dir
local is_dir   = require("lib.fil").is_dir
local exists   = require("lib.fil").exists

-- normalize path:
-- vim.fn.resolve(path)

local cdir = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":p:h")
local cmod = vim.fn.fnamemodify(cdir, ":t")
-- vim.notify(cdir)
local flist = list_dir(cdir)
for _, f in ipairs(flist) do
    if is_dir(f) then
        local finit = vim.fn.resolve(f .. "/" .. "init.lua")
        if exists(finit) then
            require(cmod .. "." .. vim.fn.fnamemodify(finit, ":h:t").. ".init")
        end
    else
        if vim.fn.fnamemodify(f, ":e") == "lua" then
            local fn = vim.fn.fnamemodify(f, ":t:r")
            if fn == "src" then goto CONTINUE end
            require(cmod .. "." .. fn)
        end
    end
    ::CONTINUE::
end
