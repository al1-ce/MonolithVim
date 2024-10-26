local M = {}

M.noremap = function(mode, keys, target, options)
    local t
    local opts = { noremap = true, silent = true }
    if options == nil then
        t = opts
    else
        t = options
        t.noremap = opts.noremap
        t.silent = opts.silent
    end
    vim.keymap.set(mode, keys, target, t)
end

M.remap = function(mode, keys, target, options)
    local t
    local opts = { noremap = false, silent = true }
    if options == nil then
        t = opts
    else
        t = options
        t.noremap = opts.noremap
        t.silent = opts.silent
    end
    vim.keymap.set(mode, keys, target, t)
end

M.bufnoremap = function(mode, keys, target, options)
    local t
    local opts = { noremap = true, silent = true }
    if options == nil then
        t = opts
    else
        t = options
        t.noremap = opts.noremap
        t.silent = opts.silent
    end
    vim.api.nvim_buf_set_keymap(0, mode, keys, target, t)
end

M.bufremap = function(mode, keys, target, options)
    local t
    local opts = { noremap = false, silent = true }
    if options == nil then
        t = opts
    else
        t = options
        t.noremap = opts.noremap
        t.silent = opts.silent
    end
    vim.api.nvim_buf_set_keymap(0, mode, keys, target, t)
end

return M

