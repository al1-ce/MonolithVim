local MiniMap = require('mini.map')

MiniMap.setup({
    integrations = {
        MiniMap.gen_integration.builtin_search(),
        MiniMap.gen_integration.gitsigns(),
        MiniMap.gen_integration.diagnostic({
            error = 'DiagnosticFloatingError',
            warn  = 'DiagnosticFloatingWarn',
            info  = 'DiagnosticFloatingInfo',
            hint  = 'DiagnosticFloatingHint',
      }),
    },
    symbols = {
        encode =  MiniMap.gen_encode_symbols.dot('4x2'),
        scroll_line = '',
        scroll_view = ''
    },
    window = {
        show_integration_count = false
    }
})

-- local opts = { noremap = true, silent = true }

local keymap = vim.keymap

for _, key in ipairs({ 'n', 'N', '*', '#' }) do
    keymap.set(
        'n',
        key,
        key ..
        '<Cmd>lua MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>'
    )
end


