local function load(m)
    local ok, err = pcall(require, "monolith.plugins." .. m .. ".loader")
    if not ok then
        vim.api.nvim_err_writeln("Package \"" .. m .. "\" failed to load. \n\n" .. err)
        return
    end
    return ok
end

load('libs')

load('cmp')
load('codestats')
load('dap')
load('files')
load('formatting')
load('gui')
load('hydra')
load('lsp')
load('powerline')
load('search')
load('splits')
load('tabs')
load('terminal')
load('trees')
load('utils')
load('viewers')


