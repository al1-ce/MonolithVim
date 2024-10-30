---@diagnostic disable: missing-return-value

local theme = {
    -- fill = 'TabLineFill',
    fill = { fg = '#665c54', bg = '#282828' },
    head = { fg = '#a89984', bg = '#3c3836' },
    current_tab = { fg = '#a89984', bg = '#3c3836' },
    tab = { fg = '#665c54', bg = '#282828' },
    win = { fg = '#a89984', bg = '#3c3836' },
    tail = { fg = '#a89984', bg = '#3c3836' },
}

local is_in_shpool_session = {}
local _shpool_val = os.getenv("SHPOOL_SESSION_NAME")
if _shpool_val ~= nil then
    is_in_shpool_session = {
        " @" .. _shpool_val .. " ",
        hl = theme.fill,
    }
end

return { {
    'nanozuki/tabby.nvim',
    event = { 'VimEnter' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        vim.o.showtabline = 2
        local tabby = import 'tabby.tabline'
        tabby.set(
            function(line)
                return {
                    line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                        local hl = win.is_current() and theme.current_tab or theme.tab
                        return {
                            line.sep('', theme.win, theme.win),
                            win.buf_name(),
                            line.sep('', theme.win, theme.win),
                            hl = hl,
                            margin = ' ',
                        }
                    end),
                    line.spacer(),
                    is_in_shpool_session,
                    line.tabs().foreach(function(tab)
                        local hl = tab.is_current() and theme.current_tab or theme.tab
                        return {
                            line.sep('', hl, hl),
                            tab.is_current() and '⬢' or '⬡',
                            tab.number(),
                            line.sep('', hl, hl),
                            hl = hl,
                            margin = ' ',
                        }
                    end),
                    hl = theme.fill,
                }
            end, {}
        )
    end
},
}
