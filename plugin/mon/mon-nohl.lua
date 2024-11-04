-- Based on https://github.com/nvimdev/hlsearch.nvim

local api, fn = vim.api, vim.fn
local group = api.nvim_create_augroup('Hlsearch', { clear = true })

local function stop_hl()
    if vim.v.hlsearch == 0 then
        return
    end
    local keycode = api.nvim_replace_termcodes('<Cmd>nohl<CR>', true, false, true)
    api.nvim_feedkeys(keycode, 'n', false)
end

local function start_hl()
    local res = fn.getreg('/')
    if vim.v.hlsearch ~= 1 then
        return
    end
    if res:find([[%#]], 1, true) then
        stop_hl()
        return
    end
    ok, res = pcall(fn.search, [[\%#\zs]] .. res, 'cnW')
    if ok and res == 0 then
        stop_hl()
        return
    end
end

local buffers = {}

local enabled = true

local function hs_event(bufnr)
    if buffers[bufnr] then
        return
    end
    if not enabled then return end
    buffers[bufnr] = true
    local cm_id = api.nvim_create_autocmd('CursorMoved', {
        buffer = bufnr,
        group = group,
        callback = function()
            start_hl()
        end,
        desc = 'Auto hlsearch',
    })

    local ie_id = api.nvim_create_autocmd('InsertEnter', {
        buffer = bufnr,
        group = group,
        callback = function()
            stop_hl()
        end,
        desc = 'Auto remove hlsearch',
    })

    api.nvim_create_autocmd('BufDelete', {
        buffer = bufnr,
        group = group,
        callback = function(opt)
            buffers[bufnr] = nil
            pcall(api.nvim_del_autocmd, cm_id)
            pcall(api.nvim_del_autocmd, ie_id)
            pcall(api.nvim_del_autocmd, opt.id)
        end,
    })
end

local function enable()
    if enabled then return end
    enabled = true
    api.nvim_create_autocmd('BufWinEnter', {
        group = group,
        callback = function(opt)
            hs_event(opt.buf)
        end,
        desc = 'hlsearch.nvim event',
    })
    hs_event(0)
end

local function disable()
    if not enabled then return end
    enabled = false
    vim.api.nvim_clear_autocmds({ group = group })
    buffers = {}
end

-- local function setup(opts)
--     enabled = opts.autoenable or true
--
--     if enabled then
--         enabled = false
--         enable()
--     end

    vim.api.nvim_create_user_command("NohlEnable", enable, {})
    vim.api.nvim_create_user_command("NohlDisable", disable, {})
-- end

-- return {
--     setup = setup,
-- }

