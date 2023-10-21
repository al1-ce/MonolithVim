require('pqf').setup({
    signs = {
        error = '',
        warning = '',
        info = '',
        hint = ''
    },
    show_multiple_lines = false
})

-------------------- Quickfix --------------------------------------

-- LINK: https://reviewdog.github.io/errorformat-playground/
-- Clean because of %- error
vim.opt.errorformat = {}
-- D (dub)
-- Errors form -verrors=specs (ignored)
vim.opt.errorformat:append("%-G(spec:%*[0-9]) %m")
-- Uncaught exceptions (e.g. from unit tests)
vim.opt.errorformat:append("%*[^@]@%f(%l): %m")
-- Errors in string mixins
vim.opt.errorformat:append("%f-mixin-%*[0-9](%l\\,%c): %m")
vim.opt.errorformat:append("%f-mixin-%*[0-9](%l): %m")
-- Normal compile errors
vim.opt.errorformat:append("%f(%l\\,%c): %t%*[^:]: %m")
vim.opt.errorformat:append("%f(%l): %t%*[^:]: %m")
-- C (gcc)
vim.opt.errorformat:append("%f:%l:%c: %t%*[^:]: %m")
-- TS
vim.opt.errorformat:append("%f:%l:%c - %trror TS%n: %m")
vim.opt.errorformat:append("%f(%l\\,%c) %trror TS%n: %m")

-- Most general error there could be
vim.opt.errorformat:append("%t%*[^:]: %m")

