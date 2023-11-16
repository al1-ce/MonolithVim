local function load(m)
    local ok, err = pcall(require, "monolith.plugins.gui." .. m)
    if not ok then
        vim.api.nvim_err_writeln("Package \"" .. m .. "\" failed to load. \n\n" .. err)
        return
    end
    return ok
end

load("fidget")
-- load("hoversplit")
-- load("minimap")
-- load("image")
load("noice")
load("dressing")
load("notify")
load("scrollbar")
-- load("twilight")
-- load("zen")
