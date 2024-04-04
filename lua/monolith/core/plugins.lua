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
    'nvim-lua/plenary.nvim',
    'nvim-neotest/nvim-nio',
    -- web icons
    'kyazdani42/nvim-web-devicons',
    -- ui components
    'MunifTanjim/nui.nvim',
    -- async (required by UFO?)
    "kevinhwang91/promise-async",

    -- --------------------------------- Syntax --------------------------------- --
    -- 'fladson/vim-kitty',
    'tikhomirov/vim-glsl',

    -- ------------------------------ File managers ----------------------------- --
    -- FZF has priority over Telescope because Telescope often skips things
    'nvim-telescope/telescope.nvim',
    -- project manager
    "ahmedkhalf/project.nvim",
    -- file manager as buffer
    "stevearc/oil.nvim",
    -- FZF
    "ibhagwan/fzf-lua",

    -- -------------------------------- Trees ----------------------------------- --
    -- undo tree
    'mbbill/undotree',
    -- TodoTree
    'folke/todo-comments.nvim',
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
    -- 'jay-babu/mason-null-ls.nvim',
    'jay-babu/mason-nvim-dap.nvim',
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
    'hrsh7th/nvim-cmp', -- autocompletion engine
    'hrsh7th/cmp-nvim-lsp', -- allows to use lsp
    -- 'hrsh7th/cmp-path', -- allows to do paths
    'hrsh7th/cmp-buffer', -- allows to use buffer text
    -- 'hrsh7th/cmp-cmdline', -- commandline?
    -- Popup snippets
    'hrsh7th/cmp-vsnip', -- for popups
    'hrsh7th/vim-vsnip',
    -- Auto-close brackets
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
    {
    "NoahTheDuke/vim-just",
        event = { "BufReadPre", "BufNewFile" },
        ft = { "\\cjustfile", "*.just", ".justfile", "justfile" },
    },
    "IndianBoy42/tree-sitter-just",

    -- ------------------------------- Formatting ------------------------------- --
    -- Toggle comments
    'numToStr/Comment.nvim',
    -- Alisgn text
    'tommcdo/vim-lion', -- glip=
    -- Colour picker and colour background
    "uga-rosa/ccc.nvim",
    -- Toggle tags
    'nguyenvukhang/nvim-toggler',
    -- Draw boxes
    'jbyuki/venn.nvim',
    -- Project-wide rename
    'windwp/nvim-spectre',
    -- Better quickfix
    -- { 'yorickpeterse/nvim-pqf', commit = "b2f1882" },
    'yorickpeterse/nvim-pqf',
    -- Highlights trailing whitespaces
    "ntpeters/vim-better-whitespace",
    -- Pretty folding
    "kevinhwang91/nvim-ufo",
    -- Text to ascii art (comments)
    "olidacombe/commentalist.nvim", -- instead of comment frame

    -- -------------------------------- Powerline ------------------------------- --
    -- powerline
    'nvim-lualine/lualine.nvim',
    'meuter/lualine-so-fancy.nvim',
    -- Command suggestions
    { 'gelguy/wilder.nvim', build = ":UpdateRemotePlugins" }, -- for :
    -- Illuminate matching words
    'RRethy/vim-illuminate',

    -- --------------------------------- Search --------------------------------- --
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
    -- remove background
    'tribela/vim-transparent',
    -- lsp progressbar
    {'j-hui/fidget.nvim', tag = 'legacy' },
    -- Emacs menus
    'anuvyklack/hydra.nvim',
    -- Reworks many things
    { "folke/noice.nvim", event = "VeryLazy" },
    -- notification engine
    'rcarriga/nvim-notify',
    -- [WIP] An implementation of the Popup API from vim in Neovim
    'nvim-lua/popup.nvim',
    -- shows images
    -- { '3rd/image.nvim' },
    -- override input handling
    'stevearc/dressing.nvim',
    -- ----------------------------------- GIT ---------------------------------- --
    -- git signts ( required by scrollbar )
    'lewis6991/gitsigns.nvim',
    -- git diff
    -- "sindrets/diffview.nvim",
    -- Git wrapper
    "tpope/vim-fugitive",

    -- --------------------------------- Splits --------------------------------- --
    -- Move splits
    'sindrets/winshift.nvim',
    -- Resize splits
    'mrjones2014/smart-splits.nvim',

    -- ------------------------------- Utilities -------------------------------- --
    -- cool smart surrounding
    'tpope/vim-surround',
    -- Move lines and characters
    'fedepujol/move.nvim',
    -- dashboard
    'goolord/alpha-nvim',
    -- Sudo edit/save
    'lambdalisue/suda.vim',
    -- Session manager
    'natecraddock/sessions.nvim',
    -- Better session manager
    -- 'EricDriussi/remember-me.nvim',
    -- remember last edited line
    'ethanholz/nvim-lastplace',
    -- .todo.md files
    'aserebryakov/vim-todo-lists',
    -- Execute code lines -- :SnipRun
    -- { 'michaelb/sniprun', build = "sh ./install.sh" },

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
    -- emacs orgmode
    -- { "nvim-orgmode/orgmode", event = "VeryLazy" },
    -- 'akinsho/org-bullets.nvim',

    -- 'dstein64/vim-startuptime'
})

