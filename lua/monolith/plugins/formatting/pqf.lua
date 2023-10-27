require('pqf').setup({
    signs = {
        error = '',
        warning = '',
        info = '',
        hint = ''
    },
    show_multiple_lines = true,
    max_filename_length = 0,
    hide_placeholder_path = true
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
vim.opt.errorformat:append("%E%f:%l %m")
-- C (gcc)
vim.opt.errorformat:append("%f:%l:%c: %t%*[^:]: %m")
-- TS
vim.opt.errorformat:append("%f:%l:%c - %trror TS%n: %m")
vim.opt.errorformat:append("%f(%l\\,%c) %trror TS%n: %m")
-- DART
-- I give up
-- vim.opt.errorformat:append("%E%f:%l:%c:,%C%trror: %m\\.,%Z%m")
vim.opt.errorformat:append("%E%f:%l:%c:")
-- vim.opt.errorformat:append("%E%f:%l:%c:")
-- vim.opt.errorformat:append("%+CError:\\ %m")
-- vim.opt.errorformat:append("%+C%m")
-- vim.opt.errorformat:append("%+Z%*\\s%*\\^")

-- Most general error there could be
vim.opt.errorformat:append("%t%*[^:]: %m")
-- sily.logger log format

