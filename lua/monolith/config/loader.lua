local function load(m)
    local ok, err = pcall(require, "monolith.config." .. m)
    if not ok then
        vim.api.nvim_err_writeln("Package \"" .. m .. "\" failed to load. \n\n" .. err)
        return
    end
    return ok
end

load('alpha')
load('colorpicker')
load('comment')
load('common')
load('dap')
load('easypick')
load('hydra')
load('lsp')
load('lualine')
load('minimap')
load('scrollbar')
load('sidebar')
load('tabby')
load('telescope')
load('tree')
load('wilder')


