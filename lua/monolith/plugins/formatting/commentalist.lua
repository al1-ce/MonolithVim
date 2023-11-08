local job = require("plenary.job")

local configdir = vim.fn.fnamemodify(vim.fn.expand("$MYVIMRC"), ":p:h")

require("commentalist").setup({
    -- renderers = {
    --     sily_3x4 = {
    --         render = function(lines, font)
    --             table.insert(lines, 1, "[com:" .. font "]")
    --             table.insert(lines, "[ment:" .. font "]")
    --             return lines
    --         end,
    --         fonts = function(register)
    --             register(configdir .. "/res/sily_3x4.flf")
    --         end,
    --     }
    -- }
})
