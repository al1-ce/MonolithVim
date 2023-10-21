-- Plugin loading

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- -------------------------------- Libraries ------------------------------- --
    -- Async code
    'lewis6991/impatient.nvim',
    -- Async rulez
    'tpope/vim-dispatch',
    -- Simple :AsyncRun command
    'skywind3000/asyncrun.vim',
    -- > All the lua functions I don't want to write twice.
    'nvim-lua/plenary.nvim',
    -- web icons
    'kyazdani42/nvim-web-devicons',
    -- easily parse the command inputted by rs
    'winston0410/cmd-parser.nvim',
    -- ui components
    'MunifTanjim/nui.nvim',
    -- py
    'roxma/vim-hug-neovim-rpc',
    -- yarp
    'roxma/nvim-yarp',
    -- cp
    'nixprime/cpsm',

    -- --------------------------------- Themes --------------------------------- --
    'morhetz/gruvbox',
    'luisiacc/gruvbox-baby',
    'almo7aya/neogruvbox.nvim',
    'savq/melange',
    'catppuccin/nvim',
    'folke/tokyonight.nvim',
    'elvessousa/sobrio',
    'yonlu/omni.vim',

    -- --------------------------------- Syntax --------------------------------- --
    'fladson/vim-kitty',
    'tikhomirov/vim-glsl',

    -- ------------------------------ File managers ----------------------------- --
    'nvim-telescope/telescope.nvim',
    -- extensions:
    'nvim-telescope/telescope-file-browser.nvim',
    'nvim-telescope/telescope-vimspector.nvim',
    'chip/telescope-software-licenses.nvim',
    'crispgm/telescope-heading.nvim',
    'nvim-telescope/telescope-symbols.nvim',
    -- 'dharmx/telescope-media.nvim'
    -- creates telescope pickers
    'axkirillov/easypick.nvim',
    -- project manager
    "ahmedkhalf/project.nvim",
    -- file manager as buffer
    "stevearc/oil.nvim",
    -- ranger
    "kevinhwang91/rnvimr",

    -- -------------------------------- Trees ----------------------------------- --
    -- file tree
    'nvim-tree/nvim-tree.lua',
    -- undo tree
    'mbbill/undotree',
    -- sidebar
    'sidebar-nvim/sidebar.nvim',
    -- sidebar dap breakpoints
    'sidebar-nvim/sections-dap',
    -- TodoTree
    'AmeerTaweel/todo.nvim',
    -- Goto quickfix files
    'yssl/QFEnter',

    -- ----------------------------------- LSP ---------------------------------- --
    -- Configs for the Nvim LSP client (:help lsp)
    'neovim/nvim-lspconfig',
    -- lsp but formatting
    'nvimtools/none-ls.nvim',
    -- many cool features like hover diagnostic    
    'nvimdev/lspsaga.nvim',
    -- Nvim lua api
    'folke/neodev.nvim',
    -- Show function signature
    'ray-x/lsp_signature.nvim',
    -- Show icons in snippets
    'onsails/lspkind.nvim',
    -- parser
    'nvim-treesitter/nvim-treesitter',
    -- LSP package manager
    'williamboman/mason.nvim',
    -- mason integration
    'williamboman/mason-lspconfig.nvim',
    'jayp0521/mason-null-ls.nvim',
    'jayp0521/mason-nvim-dap.nvim',
    -- LSP Servers
    "hinell/lsp-timeout.nvim",
    -- Auto-create colorscheme for missing format colors
    'folke/lsp-colors.nvim',
    -- ----------------------------------- DAP ---------------------------------- --
    -- nvim-dap is a Debug Adapter Protocol client implementation
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    -- ---------------------------------- Lint --------------------------------- --
    -- linter
    'mfussenegger/nvim-lint',
    -- ------------------------------ Autocomplete ----------------------------- --
    -- A completion engine plugin for neovim written in Lua
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    -- Popup snippets
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    -- json chemas
    'b0o/schemastore.nvim',
    -- Auto-close brackets
    -- 'windwp/nvim-autopairs',
    {
        "altermo/ultimate-autopair.nvim",
        event = {"InsertEnter", "CmdlineEnter"},
        branch = "v0.6", -- TODO: check later
    },

    -- ------------------------------- Languages -------------------------------- --
    -- Dart
    'dart-lang/dart-vim-plugin',
    -- 'natebosch/vim-lsc'
    -- 'natebosch/vim-lsc-dart'

    -- ------------------------------- Formatting ------------------------------- --
    -- Toggle comments
    'numToStr/Comment.nvim',
    -- Formatter runner
    'lukas-reineke/lsp-format.nvim',
    -- Comment frame
    's1n7ax/nvim-comment-frame',
    -- Alisgn text
    'junegunn/vim-easy-align',
    -- Colour picker and colour background
    "uga-rosa/ccc.nvim",
    -- Toggle tags
    'nguyenvukhang/nvim-toggler',
    -- Draw boxes
    'jbyuki/venn.nvim',
    -- Project-wide rename
    'windwp/nvim-spectre',
    -- Better quickfix
    'yorickpeterse/nvim-pqf',


    -- -------------------------------- Powerline ------------------------------- --
    -- powerline
    'nvim-lualine/lualine.nvim',
    -- Command suggestions
    { 'gelguy/wilder.nvim', build = ":UpdateRemotePlugins" },
    -- Illuminate matching words
    'RRethy/vim-illuminate',

    -- --------------------------------- Search --------------------------------- --
    -- [0/10] /in -- Display number of search matches
    'google/vim-searchindex',
    -- range hightlight (:10,15)
    -- 'winston0410/range-highlight.nvim',
    -- Jump with keys
    'easymotion/vim-easymotion',
    -- Remove search highlight automatically
    "nvimdev/hlsearch.nvim",

    -- ---------------------------------- Tabs ---------------------------------- --
    -- tab management
    'nanozuki/tabby.nvim',

    -- ----------------------------------- GUI ---------------------------------- --
    -- scrollbar
    'petertriho/nvim-scrollbar',
    -- minimap
    { 'echasnovski/mini.map', version = '*' },
    -- remove background
    'tribela/vim-transparent',
    -- lsp progressbar
    {'j-hui/fidget.nvim', tag = 'legacy' },
    -- Emacs menus
    'anuvyklack/hydra.nvim',
    -- GUI lib
    "MunifTanjim/nui.nvim",
    -- Reworks many things
    { "folke/noice.nvim", event = "VeryLazy" },
    "folke/zen-mode.nvim",
    "folke/twilight.nvim",
    -- Help in split
    "roobert/hoversplit.nvim",
    -- notification engine
    'rcarriga/nvim-notify',
    -- [WIP] An implementation of the Popup API from vim in Neovim
    'nvim-lua/popup.nvim',
    -- ----------------------------------- GIT ---------------------------------- --
    -- git signts (required by something i think)
    'lewis6991/gitsigns.nvim',
    -- git diff
    "sindrets/diffview.nvim",
    -- Git wrapper
    "tpope/vim-fugitive",

    -- --------------------------------- Splits --------------------------------- --
    -- Move splits
    'sindrets/winshift.nvim',
    -- Resize splits
    'mrjones2014/smart-splits.nvim',

    -- -------------------------------- Terminal -------------------------------- --
    -- Toggle terminal
    { "akinsho/toggleterm.nvim", version = '*' },

    -- ------------------------------- Utilities -------------------------------- --
    -- cool smart surrounding
    'tpope/vim-surround',
    -- visit links
    'xiyaowong/link-visitor.nvim',
    -- Move lines and characters
    'fedepujol/move.nvim',
    -- dashboard
    'goolord/alpha-nvim',
    -- Sudo edit/save
    'lambdalisue/suda.vim',
    -- Hacker scratchpad
    'metakirby5/codi.vim',
    -- Game
    "eandrju/cellular-automaton.nvim",
    'zane-/howdoi.nvim',
    'axieax/urlview.nvim',
    -- Session manager
    'natecraddock/sessions.nvim',
    -- Better session manager
    'EricDriussi/remember-me.nvim',
    -- remember last edited line
    'ethanholz/nvim-lastplace',
    -- mkdir -r
    'jghauser/mkdir.nvim',
    -- clipboard
    'AckslD/nvim-neoclip.lua',

    -- -------------------------------- Viewers --------------------------------- --
    -- Preview markdown
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    -- Preview markdown
    {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},
})

