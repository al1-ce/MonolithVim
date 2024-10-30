return {
    -- autoreload buffers
    { 'djoshea/vim-autoread' },
    -- close inactive buffers
    {
        'axkirillov/hbac.nvim',
        opts = {
            autoclose = true,
            threshold = 10,
            close_buffers_with_windows = false,
        }
    },
    -- remember last edited line
    {
        'ethanholz/nvim-lastplace',
        opts = {
            lastplace_ignore_buftype = { "quickfix", "nofile", "help", "alpha" },
            lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
            lastplace_open_folds = true
        }
    },
}
