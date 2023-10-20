local function load(m)
    local ok, err = pcall(require, "monolith.plugins." .. m .. ".loader")
    if not ok then
        vim.api.nvim_err_writeln("Package \"" .. m .. "\" failed to load. \n\n" .. err)
        return
    end
    return ok
end

-- TODO: move to respective folders and load like load('lsp') with pcall "monolith.plugins." .. m .. "loader" ? 

load('libs')

load('autocomplete')
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


