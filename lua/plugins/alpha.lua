return {
    -- dashboard [ \D ]
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local header = {
                type = "text",
                val = "",
                opts = {
                    position = "center",
                    hl = "Text",
                }
            }

            local date = os.date(" %A, %b %d")

            local heading = {
                type = "text",
                val = " T O H A  H E A V Y  I N D U S T R I E S  ∴ ",
                opts = {
                    position = "center",
                    hl = "Special",
                }
            }

            local hydraHelp = "<cmd>lua require('hydra').activate(require('plugins.hydra.manual').hydra())<cr>"
            local fzfProjects = "<cmd>lua require('plugins.hydra.files').fzfProjects()<cr>"

            --- @param sc string
            --- @param txt string
            --- @param keybind string? optional
            --- @param keybind_opts table? optional
            local function button(sc, txt, keybind, keybind_opts)
                local sc_ = sc:gsub("%s", ""):gsub(vim.g.mapleader, "<leader>")

                local opts = {
                    position = "center",
                    shortcut = "",
                    cursor = 1,
                    width = 15,
                    -- width = 46,
                    align_shortcut = "left",
                    hl_shortcut = "Comment",
                    shrink_margin = false,
                }
                if keybind then
                    keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
                    opts.keymap = { "n", sc_, keybind, keybind_opts }
                end

                local function on_press()
                    local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
                    vim.api.nvim_feedkeys(key, "t", false)
                end

                return {
                    type = "button",
                    val = txt,
                    on_press = on_press,
                    opts = opts,
                }
            end

            local buttons = {
                type = "group",
                val = {
                    button("∖fr", "> open oldfiles", "<cmd>FzfLua oldfiles<cr>"),
                    button("∖fp", "> open projects", fzfProjects),
                    button("∖ce", "> open config", "<cmd>edit $MYVIMRC | tcd %:p:h<cr>"),
                    button("∖h ", "> open manual", hydraHelp),
                    button("e  ", "> new file", "<cmd>enew<cr>"),
                    button("q  ", "> quit", "<cmd>qa<cr>"),
                },
                opts = {
                    spacing = 0,
                    hl = "Text",
                },
            }

            local footer = {
                type = "text",
                val = "Today is" .. date,
                opts = {
                    position = "center",
                    hl = "Tag",
                }
            }

            local plugins = 0

            if package.loaded["lazy"] then
                plugins = #(require("lazy").plugins())
            end


            local footer_2 = {
                type = "text",
                val = "Authority downloaded " .. plugins .. " entities to base reality",
                opts = {
                    position = "center",
                    hl = "Tag",
                },
            }

            local function get_time()
                local current_hour = tonumber(os.date("%H"))

                if current_hour < 5 then
                    return "Good night"
                elseif current_hour < 12 then
                    return "Good morning"
                elseif current_hour < 17 then
                    return "Good afternoon"
                elseif current_hour < 20 then
                    return "Good evening"
                else
                    return "Good night"
                end
            end

            local footer_3 = {
                type = "text",
                val = get_time(),
                opts = {
                    position = "center",
                    hl = "Conditional",
                },
            }

            local section = {
                header = header,
                heading = heading,
                buttons = buttons,
                footer = footer,
                footer_2 = footer_2,
                footer_3 = footer_3,
            }

            local height = tonumber(vim.api.nvim_command_output("echo &lines")) or 0
            -- local height = tonumber(vim.api.nvim_command_output("echo winheight('%')")) or 0

            local function round(val)
                if val % 1 < 0.5 then return math.floor(val) end
                return math.ceil(val)
            end

            local opts = {
                layout = {
                    { type = "padding", val = round(height / 2 - 9) },
                    { type = "padding", val = 1 },
                    section.heading,
                    { type = "padding", val = 1 },
                    section.buttons,
                    { type = "padding", val = 1 },
                    section.footer_2,
                },
                opts = {
                    margin = 44,
                },
            }

            require("alpha").setup(opts)

            -- local logo = [[
            --   ⠀⠀⣀⣀⡀⠀⠀⣀⣀⣀⣀⣀⣀⠀⠀⠀⣀⣀⣀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⣀⣀⡀⠀⢀⣀⡀⠀⢀⣀⣀⣀⣀⣀⡀⠀⠀
            --   ⣴⣿⠟⠛⢿⣦⡀⣿⡟⠛⠛⠛⣿⣷⣰⣿⠟⠛⢿⣷⡄⢠⣠⣤⣿⠻⠗⠀⣴⣿⠟⠛⢿⣦⣸⣿⣧⣾⡿⢛⣿⡿⠟⠻⣿⣦⠀
            --   ⣿⡇⠀⠀⠀⣿⡇⣿⣷⣄⡀⠀⠉⠁⣿⣇⠀⠀⠀⣿⡇⣀⡉⠻⢿⣶⣄⡰⣿⣇⠀⠀⠀⣿⡿⣿⣿⣅⡀⢸⣿⡀⠀⠀⢸⣿⠀
            --   ⠙⠿⣷⣶⣦⣿⡇⠛⠋⠛⢿⣷⣤⡀⠙⠿⣷⣶⡦⣿⡇⢿⣷⣶⣶⣿⣿⣿⠙⠿⣷⣶⡆⣿⡟⠛⠋⠻⢿⣶⣿⣿⣷⣶⣼⣿
            -- ]]
        end
    },
}
