local noremap = require("utils.noremap")
local sysdep = require("utils.sysdep")

return {
    -- A completion engine plugin for neovim written in Lua
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp', -- allows to use lsp
            -- 'hrsh7th/cmp-path', -- allows to do paths
            'hrsh7th/cmp-buffer',   -- allows to use buffer text
            'hrsh7th/cmp-cmdline',  -- commandline!
            -- Popup snippets
            'hrsh7th/cmp-vsnip',    -- for popups
            'hrsh7th/vim-vsnip',
            'onsails/lspkind.nvim',
        },
        config = function()
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local feedkey = function(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end

            require('lspkind').init({
                symbol_map = {
                    Text = "",
                    Method = "", -- 󰆧
                    Function = "󰊕",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰓹",
                    Unit = "󰑭",
                    Value = "",
                    Enum = "󱡠",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "",
                    Reference = "",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "",
                },
            })

            local cmp = require('cmp')
            local str = require("cmp.utils.str")
            local types = require("cmp.types")
            ---@diagnostic disable-next-line: missing-fields
            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    -- ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif vim.fn["vsnip#available"](1) == 1 then
                            feedkey("<Plug>(vsnip-expand-or-jump)", "")
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                            feedkey("<Plug>(vsnip-jump-prev)", "")
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<Up>'] = cmp.mapping(function(fallback) fallback() end),
                    ['<Down>'] = cmp.mapping(function(fallback) fallback() end),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' }, -- For vsnip users.
                    -- { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                    { name = 'buffer' },
                }),
                window = {
                    completion = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                },
                ---@diagnostic disable-next-line: missing-fields
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(p_entry, p_vim_item)
                        local kind = require('lspkind').cmp_format({
                            mode = 'symbol_text',  -- show only symbol annotations
                            maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        })(p_entry, p_vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. ""
                        kind.menu = "" .. (strings[2] or "") .. ""

                        return kind
                    end
                },
                enabled = function()
                    -- disable completion in comments
                    local context = require 'cmp.config.context'
                    -- keep command mode completion enabled when cursor is in a comment
                    if vim.api.nvim_get_mode().mode == 'c' then
                        return true
                    else
                        return not context.in_treesitter_capture("comment")
                            and not context.in_syntax_group("Comment")
                    end
                end
            })
            -- `/` cmdline setup.
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                },
                view = {
                    entries = { name = 'wildmenu', separator = '  ' }
                },
            })
            -- `:` cmdline setup.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' }
                        }
                    }
                }),
                view = {
                    entries = { name = 'wildmenu', separator = '  ' }
                },

            })
        end
    }, -- autocompletion engine
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
                    extra = false,
                }
            }

            ft({ 'd' }, ft.get('c'))
            ft({ 'sdl' }, ft.get('c'))
            ft({ 'sdlang' }, ft.get('c'))

            local commentApi = require("Comment.api")
            local commentEsc = vim.api.nvim_replace_termcodes(
                '<ESC>', true, false, true
            )
            noremap("v", "<C-/>", function()
                vim.api.nvim_feedkeys(commentEsc, 'nx', false)
                commentApi.toggle.linewise(vim.fn.visualmode())
            end, { desc = "Toggles comment linewize" })
            noremap("v", "<C-S-/>", function()
                vim.api.nvim_feedkeys(commentEsc, 'nx', false)
                commentApi.toggle.blockwise(vim.fn.visualmode())
            end, { desc = "Toggles comment blockwise" })
            noremap("n", "<C-/>", commentApi.toggle.linewise.current, { desc = "Toggles comment" })
            noremap("i", "<C-/>", commentApi.toggle.linewise.current, { desc = "Toggles comment" })
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
        config = {
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
    {
        'windwp/nvim-spectre',
        dependencies = { "nvim-lua/plenary.nvim" },
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
    -- Edit search as buffer
    'dyng/ctrlsf.vim',
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
            { "<leader>bd", "<cmd>JustDefault<cr>",        mode = "n", noremap = true, silent = true, desc = "" },
            { "<leader>bb", "<cmd>JustBuild<cr>",          mode = "n", noremap = true, silent = true, desc = "" },
            { "<leader>br", "<cmd>JustRun<cr>",            mode = "n", noremap = true, silent = true, desc = "" },
            { "<leader>bt", "<cmd>JustTest<cr>",           mode = "n", noremap = true, silent = true, desc = "" },
            { "<leader>ba", "<cmd>JustSelect<cr>",         mode = "n", noremap = true, silent = true, desc = "" },
            { "<leader>bs", "<cmd>JustStop<cr>",           mode = "n", noremap = true, silent = true, desc = "" },
        },

    },
}
