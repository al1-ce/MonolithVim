local function load(m)
    local ok, err = pcall(require, "monolith.config.lsp." .. m)
    if not ok then
        vim.api.nvim_err_writeln("Package \"" .. m .. "\" failed to load. \n\n" .. err)
        return
    end
    return ok
end

load("autopairs")
load("cmp")
load("fidget")
load("hoversplit")
load("lsp-colors")
load("lsp-signature")
load("lsp-timeout")
load("lspconfig")
load("lspsaga")
load("mason")
load("null-ls")
load("treesitter")

