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

    -- ------------------------------ File managers ----------------------------- --
    -- FZF has priority over Telescope because Telescope often skips things
    'nvim-telescope/telescope.nvim',
    -- project manager [ \fp ]
    "ahmedkhalf/project.nvim",
    -- file manager as buffer [ - ]
    "stevearc/oil.nvim",
    -- FZF [ ;ff ;fr ;fp ;fg \ff ... ]
    "ibhagwan/fzf-lua",
    -- FZF alternative
    -- "Yggdroot/LeaderF",

    -- -------------------------------- Trees ----------------------------------- --
    -- undo tree [ \fu ]
    'mbbill/undotree',
    -- TodoTree [ \vt ]
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
    -- LSP package manager [ \pm ]
    'williamboman/mason.nvim',
    -- mason integration
    'williamboman/mason-lspconfig.nvim',
    -- 'jay-babu/mason-null-ls.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    -- Auto-create colorscheme for missing format colors
    'folke/lsp-colors.nvim',

    -- ----------------------------------- DAP ---------------------------------- --
    -- DAP [ \dd ]
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
    -- auto-close html tags
    'windwp/nvim-ts-autotag',

    -- ------------------------------- Formatting ------------------------------- --
    -- Toggle comments [ C-/ ]
    'numToStr/Comment.nvim',
    -- Alisgn text [ glip= ]
    'tommcdo/vim-lion',
    -- Colour picker and colour background
    "uga-rosa/ccc.nvim",
    -- Toggle tags [ \tp ]
    'nguyenvukhang/nvim-toggler',
    -- Draw boxes [ \td ]
    'jbyuki/venn.nvim',
    -- Project-wide rename [ \fR ]
    'windwp/nvim-spectre',
    -- Better quickfix
    -- { 'yorickpeterse/nvim-pqf', commit = "b2f1882" },
    'yorickpeterse/nvim-pqf',
    -- Highlights trailing whitespaces
    "ntpeters/vim-better-whitespace",
    -- Pretty folding [ zc zC za zA zR zM ]
    "kevinhwang91/nvim-ufo",
    -- Text to ascii art (comments) [ \ta ]
    "olidacombe/commentalist.nvim", -- instead of comment frame

    -- -------------------------------- Powerline ------------------------------- --
    -- powerline
    'nvim-lualine/lualine.nvim',
    'meuter/lualine-so-fancy.nvim',
    -- Command suggestions [ : ]
    { 'gelguy/wilder.nvim', build = ":UpdateRemotePlugins" },
    -- Illuminate matching words
    'RRethy/vim-illuminate',

    -- --------------------------------- Search --------------------------------- --
    -- Jump with keys [ s ]
    'easymotion/vim-easymotion',
    -- Remove search highlight automatically
    "nvimdev/hlsearch.nvim",

    -- ---------------------------------- Tabs ---------------------------------- --
    -- tab management (tabline)
    'nanozuki/tabby.nvim',

    -- ----------------------------------- GUI ---------------------------------- --
    -- scrollbar
    'petertriho/nvim-scrollbar',
    -- remove background
    'tribela/vim-transparent',
    -- lsp progressbar
    {'j-hui/fidget.nvim', tag = 'legacy' },
    -- Emacs menus [ \ ]
    'anuvyklack/hydra.nvim',
    -- Reworks many things, makes notifications [ ;; ]
    -- TODO: remove?
    { "folke/noice.nvim", event = "VeryLazy" },
    -- notification engine
    'rcarriga/nvim-notify',
    -- [WIP] An implementation of the Popup API from vim in Neovim
    'nvim-lua/popup.nvim',
    -- shows images
    -- { '3rd/image.nvim' },
    -- override input handling (makes input pop up sometimes...)
    'stevearc/dressing.nvim',
    -- true zen
    'folke/zen-mode.nvim',
    -- jet another buffer switcher
    'matbme/JABS.nvim',

    -- ----------------------------------- GIT ---------------------------------- --
    -- git signts ( required by scrollbar )
    'lewis6991/gitsigns.nvim',
    -- Git wrapper [ :Git ]
    "tpope/vim-fugitive",

    -- --------------------------------- Splits --------------------------------- --
    -- Move splits [ A-S-Right ... ]
    'sindrets/winshift.nvim',
    -- Resize splits [ A-C-Right ... ]
    'mrjones2014/smart-splits.nvim',

    -- ------------------------------- Utilities -------------------------------- --
    -- cool smart surrounding [ \tr \tR ]
    'tpope/vim-surround',
    -- Move lines and characters [ A-Up A-Down ]
    'fedepujol/move.nvim',
    -- dashboard [ \D ]
    'goolord/alpha-nvim',
    -- Sudo edit/save [ \hw \hr ]
    'lambdalisue/suda.vim',
    -- Session manager [ :SessionsLoad :SessionsSave ]
    'natecraddock/sessions.nvim',
    -- remember last edited line
    'ethanholz/nvim-lastplace',
    -- .todo.md files
    'aserebryakov/vim-todo-lists',

    -- -------------------------------- Viewers --------------------------------- --
    -- Preview markdown [ \vM ]
    -- TODO: consider deleting
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    -- Preview markdown [ \vm ]
    {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},

    -- 'dstein64/vim-startuptime'

    -- tips on start
    {
      "TobinPalmer/Tip.nvim",
      event = "VimEnter",
      init = function()
        -- Default config
        require("tip").setup({
          seconds = 2,
          title = "Tip!",
          url = "https://vtip.43z.one", -- Or https://vimiscool.tech/neotip
        })
      end,
    },

})

