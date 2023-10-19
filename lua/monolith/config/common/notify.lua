require('notify').setup({
    background_color = '#000000',
    stages = 'slide',

    on_open = function (win)
      vim.api.nvim_win_set_config(win, { border = "single" })
    end,
    -- require("notify")("My super important message", "warn", {title="Title"}) 
})

