local function load(m)
    local ok, err = pcall(require, "monolith.plugins.lsp." .. m)
    if not ok then
        vim.api.nvim_err_writeln("Package \"" .. m .. "\" failed to load. \n\n" .. err)
        return
    end
    return ok
end

-- load("colors")
-- load("neoconf") -- must be loaded before lspconfig
load("config")
load("mason")
load("neodev")
load("null")
load("saga")
load("signature")
load("timeout")
load("treesitter")

