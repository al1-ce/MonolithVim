local opts = { noremap = false, silent = true }

local function remap(mode, keys, target, options)
    local t
    if options == nil or #options == 0 then
        t = opts
    else
        t = options
        t.noremap = opts.noremap
        t.silent = opts.silent
    end
    vim.keymap.set(mode, keys, target, t)
end

return remap
