local function load(m)
    local ok, err = pcall(require, "monolith.plugins.formatting." .. m)
    if not ok then
        vim.api.nvim_err_writeln("Package \"" .. m .. "\" failed to load. \n\n" .. err)
        return
    end
    return ok
end

load("align")
load("ccc")
load("comment")
load("illuminate")
load("nvim-toggler")
load("pqf")
load("spectre")
