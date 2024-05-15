local noremap = require("utils.noremap")

return {
    -- A completion engine plugin for neovim written in Lua
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp', -- allows to use lsp
            -- 'hrsh7th/cmp-path', -- allows to do paths
            'hrsh7th/cmp-buffer',   -- allows to use buffer text
            -- 'hrsh7th/cmp-cmdline', -- commandline?
            -- Popup snippets
            'hrsh7th/cmp-vsnip', -- for popups
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
                ---@diagnostic disable-next-line: missing-fields
                formatting = {
                    format = require('lspkind').cmp_format({
                        mode = 'symbol_text',  -- show only symbol annotations
                        maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        -- The function below will be called before any actual modifications from lspkind
                        before = function(entry, vim_item)
                            return vim_item
                        end
                    })
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
        config = function()
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
                        severity_limit = 'Warning',
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
            end, {desc = "Toggles comment linewize"});
            noremap("v", "<C-S-/>", function()
                vim.api.nvim_feedkeys(commentEsc, 'nx', false)
                commentApi.toggle.blockwise(vim.fn.visualmode())
            end, {desc = "Toggles comment blockwise"});
            noremap("n", "<C-/>", commentApi.toggle.linewise.current, {desc = "Toggles comment"});
            noremap("i", "<C-/>", commentApi.toggle.linewise.current, {desc = "Toggles comment"});
        end
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
    "uga-rosa/ccc.nvim",
    -- Project-wide rename [ \fR ]
    {
        'windwp/nvim-spectre',
        dependencies = { "nvim-lua/plenary.nvim" },
        config = {
            live_update = true,
            mapping = {
                ['send_to_qf'] = {
                    map = "<leader>Q",
                    cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                    desc = "Send all items to quickfix"
                },
            }
        }
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

            noremap('n', 'zR', require('ufo').openAllFolds, {desc = "Opens all folds"})
            noremap('n', 'zM', require('ufo').closeAllFolds, {desc = "Closes all folds"})

            noremap('n', 'zc', 'za', {desc = "Toggles single fold"})
            noremap('n', 'zC', 'zA', {desc = "Toggles single fold recursively"})
            noremap('n', 'za', 'zc', {desc = "Closes single fold"})
            noremap('n', 'zA', 'zC', {desc = "Closes single fold recursively"})

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

            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { 'treesitter', 'indent' }
                end,
                fold_virt_text_handler = handler
            })
        end
    },
    -- Text to ascii art (comments) [ \ta ]
    {
        "olidacombe/commentalist.nvim",
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'numToStr/Comment.nvim',
        },
        config = true
    }, -- instead of comment frame
}
