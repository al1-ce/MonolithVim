local function load(m)
    local ok, err = pcall(require, "monolith.plugins.utils." .. m)
    if not ok then
        vim.api.nvim_err_writeln("Package \"" .. m .. "\" failed to load. \n\n" .. err)
        return
    end
    return ok
end

load("alpha")
load("cellularautomaton")
load("justbuild")
load("lastplace")
load("linkvisitor")
load("move")
load("neoclip")
load("rememberme")
load("sessions")
load("todo")
load("urlview")
