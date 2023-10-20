local function load(m)
    local ok, err = pcall(require, "monolith.config." .. m)
    if not ok then
        vim.api.nvim_err_writeln("Package \"" .. m .. "\" failed to load. \n\n" .. err)
        return
    end
    return ok
end

-- TODO: move to respective folders and load like load('lsp') with pcall "monolith.config." .. m .. "loader" ? 

load('alpha')
load('comment')
load('common')
load('dap')
load('easypick')
load('hydra')
load('lsp')
load('lualine')
load('noice')
load('minimap')
load('scrollbar')
load('sidebar')
load('tabby')
load('telescope')
load('tree')
load('wilder')


