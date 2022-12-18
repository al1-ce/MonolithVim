require('gitsigns').setup({
    signcolumn = true
})

require('hlslens').setup()

require("scrollbar").setup({
    marks = {
        Cursor = { color = '#504945', text = '█' },
        Search = { color = '#FABD2F' },
        Error = { color = '#FB4934' },
        Warn = { color = '#D65D0E' },
        Info = { color = '#458599' },
        Hint = { color = '#689D6A' },
        Misc = { color = '#B16286' },
        GitAdd = { color = '#B8BB26', text = '│' },
        GitChange = { color = '#D79921', text = '│' },
        GitDelete = { color = '#CC241D', text = '│' },
    },
    excluded_filetypes = {
        "dashboard", "alpha"
    }
})

require("scrollbar.handlers.search").setup({})
require("scrollbar.handlers.gitsigns").setup()