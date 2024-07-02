local noremap = require("utils.noremap")
local sysdep = require("utils.sysdep")

return {
    -- Auto-close brackets
    {
        "altermo/ultimate-autopair.nvim",
        event = { "InsertEnter", "CmdlineEnter" },
        branch = "v0.6", -- TODO: check later
        config = true
    },
    -- auto-close html tags
    {
        'windwp/nvim-ts-autotag',
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-ts-autotag").setup({
                autotag = {
                    enable = true,
                }
            })

            vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics,
                {
                    underline = true,
                    virtual_text = {
                        spacing = 5,
                        severity = { min = vim.diagnostic.severity.WARN },
                    },
                    update_in_insert = true,
                }
            )
        end
    },

    -- Toggle comments [ C-/ ]
    {
        'numToStr/Comment.nvim',
        lazy = false,
        config = function()
            local ft = require('Comment.ft')
            local cm = require('Comment')

            ---@diagnostic disable-next-line: missing-fields
            cm.setup {
                mappings = {
                    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                    basic = true,
                    ---Extra mapping; `gco`, `gcO`, `gcA`
                    extra = true,
                }
            }

            ft({ 'd' }, ft.get('c'))
            ft({ 'sdl' }, ft.get('c'))
            ft({ 'sdlang' }, ft.get('c'))
            ft({ 'kdl' }, ft.get('c'))

            -- local commentApi = require("Comment.api")
            -- vim.keycode is better option
            -- local commentEsc = vim.api.nvim_replace_termcodes(
            --     '<ESC>', true, false, true
            -- )
            -- noremap("v", "<C-/>", function()
            --     vim.api.nvim_feedkeys(commentEsc, 'nx', false)
            --     commentApi.toggle.linewise(vim.fn.visualmode())
            -- end, { desc = "Toggles comment linewize" })
            -- noremap("v", "<C-S-/>", function()
            --     vim.api.nvim_feedkeys(commentEsc, 'nx', false)
            --     commentApi.toggle.blockwise(vim.fn.visualmode())
            -- end, { desc = "Toggles comment blockwise" })
            -- noremap("n", "<C-/>", commentApi.toggle.linewise.current, { desc = "Toggles comment" })
            -- noremap("i", "<C-/>", commentApi.toggle.linewise.current, { desc = "Toggles comment" })
        end,
    },
    -- Alisgn text [ glip= ]
    {
        'tommcdo/vim-lion',
        config = function()
            vim.g.lion_create_map = 1
            vim.g.lion_squeeze_spaces = 1
        end
    },
    -- Colour picker and colour background
    {
        "uga-rosa/ccc.nvim",
        event = { "BufEnter", "BufNew" },
        opts = {
            highlighter = {
                auto_enable = true,
                lsp = true
            }
        },
        keys = {
            { "<leader>cp", "<cmd>CccPick<cr>", mode = "n", noremap = true, silent = true, desc = "Opens color picker" },
        },
    },
    -- Project-wide rename [ \fR ]
    -- TODO: remove in favor of replacer?
    {
        'windwp/nvim-spectre',
        dependencies = { "nvim-lua/plenary.nvim" },
        enabled = false,
        opts = {
            live_update = true,
            mapping = {
                ['send_to_qf'] = {
                    map = "<leader>Q",
                    cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                    desc = "Send all items to quickfix"
                },
            }
        },
        keys = {
            { "<leader>fR", function() require("spectre").open() end, mode = "n", noremap = true, silent = true, desc = "Opens project-wide rename" },
        },
    },
    -- Allows for alternative project-wide replacements
    -- To use:
    -- - fzf-lua's grep for value and send to qf
    -- - :Replacer
    -- - change values
    -- - :w
    -- - profit
    {
        'gabrielpoca/replacer.nvim',
        config = function()
            vim.api.nvim_create_user_command("Replacer", function()
                require("replacer").run({ save_on_write = true, rename_files = false })
            end, {})
            vim.api.nvim_create_user_command("ReplacerRename", function()
                require("replacer").run({ save_on_write = true, rename_files = true })
            end, {})
        end
    },
    -- Edit search as buffer
    -- 'dyng/ctrlsf.vim',
    -- Highlights trailing whitespaces
    "ntpeters/vim-better-whitespace",
    -- Pretty folding [ zc zC za zA zR zM ]
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { 'kevinhwang91/promise-async' },
        config = function()
            vim.o.foldcolumn = '0' -- '0' is not bad
            vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            vim.o.foldmethod = "indent"
            vim.o.foldlevelstart = 99

            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' 󰁂 %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'Macro' })
                return newVirtText
            end

            ---@diagnostic disable-next-line: missing-fields
            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { 'treesitter', 'indent' }
                end,
                fold_virt_text_handler = handler
            })
        end,
        event = "VimEnter",
        keys = {
            { "zc", "za", mode = "n", noremap = true, silent = true, desc = "Toggles single fold" },
            { "zC", "zA", mode = "n", noremap = true, silent = true, desc = "Toggles single fold recursively" },
            { "za", "zc", mode = "n", noremap = true, silent = true, desc = "Closes single fold" },
            { "zA", "zC", mode = "n", noremap = true, silent = true, desc = "Closes single fold recursively" },
        },
    },
    -- Text to ascii art (comments) [ \ta ]
    {
        "olidacombe/commentalist.nvim",
        cond = sysdep({ "boxes", "cowsay", "figlet" }),
        enabled = false,
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'numToStr/Comment.nvim',
        },
        config = true,
        keys = {
            { "<leader>ta", "<cmd>Commentalist<cr>", mode = "n", noremap = true, silent = true, desc = "Creates ascii comments" },
        },

    }, -- instead of comment frame
    {
        "jellydn/quick-code-runner.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        cond = sysdep({ "dub", "node", "npx", "python", "go" }),
        enabled = false,
        opts = {
            debug = false,
            file_types = {
                d = { "dub run --single" },
                javascript = { 'node' },
                typescript = { 'npx tsx run' },
                python = { 'python -u' },
                go = { "go run", },
            },
        },
        cmd = { "QuickCodeRunner", "QuickCodePad" },
        keys = {
            {
                "<leader>x",
                ":QuickCodeRunner<CR>",
                desc = "Quick Code Runner",
                mode = "v",
            },
            {
                "<leader>X",
                "gg0vGg$:QuickCodeRunner<CR>",
                desc = "Quick File Code Runner",
                mode = "n",
            },
            {
                "<leader>x",
                "V:QuickCodeRunner<CR>",
                desc = "Run single line",
                mode = "n",
            },
            {
                "<leader>cp",
                ":QuickCodePad<CR>",
                desc = "Quick Code Pad",
            },
        },
    },
    {
        "al1-ce/just.nvim",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'rcarriga/nvim-notify',
            'j-hui/fidget.nvim',
        },
        event = "VimEnter",
        cond = sysdep({ "aplay" }),
        opts = {
            fidget_message_limit = 32,
            play_sound = true,
            open_qf_on_error = true,
            telescope_borders = {
                prompt = { " ", " ", " ", " ", "┌", "┐", " ", " " },
                results = { " ", " ", " ", " ", "├", "┤", "┘", "└" },
                preview = { " ", " ", " ", " ", "┌", "┐", "┘", "└" }
            }
        },
        keys = {
            { "<leader>bd", "<cmd>JustDefault<cr>", mode = "n", noremap = true, silent = true, desc = "Run default task" },
            { "<leader>bb", "<cmd>JustBuild<cr>",   mode = "n", noremap = true, silent = true, desc = "Run build task" },
            { "<leader>br", "<cmd>JustRun<cr>",     mode = "n", noremap = true, silent = true, desc = "Run run task" },
            { "<leader>bt", "<cmd>JustTest<cr>",    mode = "n", noremap = true, silent = true, desc = "Run test task" },
            { "<leader>ba", "<cmd>JustSelect<cr>",  mode = "n", noremap = true, silent = true, desc = "Open task selector" },
            { "<leader>bs", "<cmd>JustStop<cr>",    mode = "n", noremap = true, silent = true, desc = "Stop current task" },
        },

    },
    -- Markdown outline
    {
        "vim-voom/VOoM",
        cmd = "Voom",
        ft = { "markdown" }
    },
    -- TOC generator
    {
        "mzlogin/vim-markdown-toc",
        config = function()
            vim.g.vmt_auto_update_on_save = 1
            vim.g.vmt_dont_insert_fence = 0
            vim.g.vmt_fence_text = "markdown-toc"
            vim.g.vmt_fence_closing_text = "markdown-toc"
            vim.g.vmt_fence_hidden_markdown_style = ""
            vim.g.vmt_cycle_list_item_markers = 0
            vim.g.vmt_list_item_char = '-'
            vim.g.vmt_include_headings_before = 0
            vim.g.vmt_list_indent_text = ''
            vim.g.vmt_link = 1
            vim.g.vmt_min_level = 1
            vim.g.vmt_max_level = 2
        end,
        ft = { "markdown" },
        cmd = { "GenTocGFM", "GenTocMarked" }
    },
    {
        'jakemason/ouroboros',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            extension_preferences_table = {
                c = { h = 2, hpp = 1 },
                h = { c = 2, cpp = 1 },
                cpp = { hpp = 2, h = 1 },
                hpp = { cpp = 2, c = 1 },
            },
            -- if this is true and the matching file is already open in a pane, we'll
            -- switch to that pane instead of opening it in the current buffer
            switch_to_open_pane_if_possible = true,
        },
        cmd = "Ouroboros",
        ft = { "c", "cpp" },
        keys = {
            { "<leader>gh", "<cmd>Ouroboros<cr>", mode = "n", noremap = true, silent = true, desc = "Switch to header", ft = { "c", "cpp" } },
        }
    },
    -- https://github.com/Wansmer/treesj/blob/main/tests/README.md
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            local lang_utils = require("treesj.langs.utils")

            require("treesj").setup({
                use_default_keymaps = false,
                check_syntax_error = true,
                max_join_length = 120,
                cursor_behavior = 'hold',
                notify = true,
                dot_repeat = true,
                on_error = nil,
                langs = {
                    d = {
                        parameters = lang_utils.set_preset_for_args(),
                        arguments = lang_utils.set_preset_for_args(),
                        aggregate_initializer = lang_utils.set_preset_for_list(),
                        block_statement = lang_utils.set_preset_for_statement({
                            both = {
                                no_format_with = { 'block_statement' },
                                recursive = false,
                            },
                            join = {
                                force_insert = ';',
                            },
                        }),
                        if_statement = { target_nodes = { 'block_statement' } },
                        function_declaration = {
                            target_nodes = { 'parameters', 'arguments' },
                        },
                        expression_statement = {
                            target_nodes = { 'parameters', 'arguments' },
                        },
                        array_literal = lang_utils.set_preset_for_list(),
                        enum = { target_nodes = { 'aggregate_initializer' } },
                    }
                },
            })
        end,
        event = "VimEnter",
        keys = {
            { "<leader>m", "<cmd>TSJToggle<cr>", mode = "n", noremap = true, silent = true, desc = "Toggle split join" },
        },
    },
    -- ;x V;x - execute lines
    -- TODO: WIP
    {
        dir = "/g/runme.nvim",
        opts = {
            filetypes = {
                javascript = {
                    cmd = "node run",
                },
                bash = {
                    cmd = "bash",
                },
                d = {
                    cmd = "dub run --single $FILENAME",
                    template = [[
                        /++ dub.sdl:
                        name: scratch
                        +/
                        import std;
                        void main() {
                            $RUNME_CODE
                        }
                    ]]
                },
                c = {
                    cmd = "gcc -o $FILEOUT $FILENAME && ./$FILEOUT",
                    template = [[
                        #include <stdio.h>
                        int main() {
                            $RUNME_CODE
                            return 0;
                        }
                    ]]
                }
            }
        },
        keys = {
            { "<leader>xc", "<cmd>Runme<cr>",      mode = "n", noremap = true, silent = true, desc = "E[X]ecute code" },
            { "<leader>xc", ":Runme<cr>",          mode = "v", noremap = true, silent = true, desc = "E[X]ecute code" },
            { "<leader>xp", "<cmd>RunmePaste<cr>", mode = "n", noremap = true, silent = true, desc = "E[X]ecute and [P]aste" },
            { "<leader>xp", ":RunmePaste<cr>",     mode = "v", noremap = true, silent = true, desc = "E[X]ecute and [P]aste" },
            { "<leader>xf", "<cmd>RunmeFile<cr>",  mode = "n", noremap = true, silent = true, desc = "E[X]ecute [F]ile" },
            { "<leader>xf", ":RunmeFile<cr>",      mode = "v", noremap = true, silent = true, desc = "E[X]ecute [F]ile" },
        },
        event = "VimEnter"
    },
    {
        "Mythos-404/xmake.nvim",
        lazy = true,
        event = "BufReadPost xmake.lua",
        config = true,
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    }
}
