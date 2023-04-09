local Hydra = require('hydra')
local colors = require('monolith.config.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

local configDraw = deepcopy(colors.persistAllow())
configDraw["on_enter"] = function() vim.o.virtualedit = 'all' end

local hintDraw = [[
┌── Draw(S) ──┬─ Select region with <C-v> ─┐
│      _↑_      │ _f_: Surround it with box    │
│   _←_  S  _→_   │                            │
│      _↓_      │ _q_: Quit                    │
└─────────────┴────────────────────────────┘
]]

function M.hydra() return Hydra({
        name = 'Draw Diagram',
        hint = hintDraw,
        config = configDraw,
        mode = '',
        heads = {
            { '<S-Left>', '<C-v>h:VBox<CR>', { desc = false } },
            { '<S-Down>', '<C-v>j:VBox<CR>', { desc = false } },
            { '<S-Up>', '<C-v>k:VBox<CR>', { desc = false } },
            { '<S-Right>', '<C-v>l:VBox<CR>', { desc = false } },
            { 'f', ':VBox<CR>', { mode = 'v' } },
            { '←', nil },
            { '↑', nil },
            { '↓', nil },
            { '→', nil },
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
