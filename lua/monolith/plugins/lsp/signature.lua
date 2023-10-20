local borders = {
      {"┌", "FloatBorder"},
      {" ", "FloatBorder"},
      {"┐", "FloatBorder"},
      {" ", "FloatBorder"},
      {"┘", "FloatBorder"},
      {" ", "FloatBorder"},
      {"└", "FloatBorder"},
      {" ", "FloatBorder"},
}

require("lsp_signature").setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
        border = borders
    },
    doc_lines = 0,
    hint_enable = false,
    timer_interval = 100,
    floating_window = false,
})

