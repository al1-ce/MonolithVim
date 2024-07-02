return {
    -- dashboard [ \D ]
    {
        'goolord/alpha-nvim',
        enabled = true,
        config = function()
            local height = tonumber(vim.api.nvim_cmd(vim.api.nvim_parse_cmd("echo &lines", {}), { output = true })) or 20

            local function round(val) if val % 1 < 0.5 then return math.floor(val) else return math.ceil(val) end end

            local heading = {
                type = "text",
                val = " T O H A  H E A V Y  I N D U S T R I E S  ∴ ",
                opts = { position = "center", hl = "Special" }
            }

            local function button(txt, keybind)
                local opts = {
                    position = "center",
                    shortcut = "",
                    cursor = 1,
                    width = 15,
                    align_shortcut = "left",
                    hl_shortcut = "Tag",
                    shrink_margin = false,
                }

                local function on_press()
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true), "t", false)
                end

                return { type = "button", val = txt, on_press = on_press, opts = opts }
            end

            local buttons = {
                type = "group",
                val = {
                    button("> open oldfiles", "<cmd>FzfLua oldfiles<cr>"),
                    button("> open projects", "<cmd>FzfLuaProjects<cr>"),
                    button("> open config", "<cmd>edit $MYVIMRC | tcd %:p:h<cr>"),
                    button("> new file", "<cmd>enew<cr>"),
                    button("> quit", "<cmd>qa<cr>"),
                },
                opts = { spacing = 0, hl = "Text" },
            }

            local plugins = #vim.fn.getscriptinfo()

            if package.loaded["lazy"] then plugins = #(require("lazy").plugins()) end

            local footer_2 = {
                type = "text",
                val = "Authority added " .. plugins .. " entities to base reality",
                opts = { position = "center", hl = "Tag" },
            }

            local opts = {
                layout = {
                    { type = "padding", val = round(height / 2 - 9) },
                    { type = "padding", val = 1 },
                    heading,
                    { type = "padding", val = 1 },
                    buttons,
                    { type = "padding", val = 1 },
                    footer_2,
                    { type = "padding", val = round(height / 2 - 9 + 5) },
                },
                opts = { margin = 44 },
            }

            require("alpha").setup(opts)
        end
    },
}
