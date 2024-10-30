local borders = import "var.borders"

return {
    {
        "MagicDuck/grug-far.nvim",
        opts = true
    },
    {
        "chrisgrieser/nvim-rip-substitute",
        cmd = "RipSubstitute",
        opts = {
            popupWin = {
                title = "rip-substitute",
                border = borders.normal,
                position = "top",
            },
            keymaps = { -- normal & visual mode, if not stated otherwise
                abort = "q",
                confirm = "<CR>",
                insertModeConfirm = "<C-CR>",
                prevSubst = "<Up>",
                nextSubst = "<Down>",
                toggleFixedStrings = "<C-f>", -- ripgrep's `--fixed-strings`
                toggleIgnoreCase = "<C-c>",   -- ripgrep's `--ignore-case`
                openAtRegex101 = "R",
            },
            prefill = {
                normal = false
            },
        },
        keys = {
            {
                "<leader>rg",
                function() import("rip-substitute").sub()  end,
                mode = { "n", "x" },
                desc = "[R]ipgrep [S]ubstitute",
            },
        },
    },

}

