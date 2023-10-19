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
    -- ---------------------------- Package managers ---------------------------- --
    -- LSP package manager
    'williamboman/mason.nvim',

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
    'zane-/howdoi.nvim',
    'axieax/urlview.nvim',
    -- creates telescope pickers
    'axkirillov/easypick.nvim',
    -- project manager
    "ahmedkhalf/project.nvim",
    "stevearc/oil.nvim",

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
    -- Better quickfix
    'yorickpeterse/nvim-pqf',
    -- Goto quickfix files
    'yssl/QFEnter',
    -- Project-wide rename
    'windwp/nvim-spectre',

    -- ----------------------------------- LSP ---------------------------------- --
    -- Configs for the Nvim LSP client (:help lsp)
    'neovim/nvim-lspconfig',
    -- lsp but formatting -- TODO: replace
    'jose-elias-alvarez/null-ls.nvim',
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
    -- mason integration
    'williamboman/mason-lspconfig.nvim',
    'jayp0521/mason-null-ls.nvim',
    'jayp0521/mason-nvim-dap.nvim',
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
    -- Auto-create colorscheme for missing format colors
    'folke/lsp-colors.nvim',
    -- json chemas
    'b0o/schemastore.nvim',
    -- Auto-close brackets
    'windwp/nvim-autopairs',

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

    -- -------------------------------- Powerline ------------------------------- --
    -- powerline
    'nvim-lualine/lualine.nvim',
    -- Command suggestions
    'gelguy/wilder.nvim',
    -- Illuminate matching words
    'RRethy/vim-illuminate',

    -- --------------------------------- Popups --------------------------------- --
    -- notification engine
    'rcarriga/nvim-notify',
    -- [WIP] An implementation of the Popup API from vim in Neovim
    'nvim-lua/popup.nvim',

    -- --------------------------------- Search --------------------------------- --
    -- [0/10] /in -- Display number of search matches
    'google/vim-searchindex',
    -- range hightlight (:10,15)
    'winston0410/range-highlight.nvim',
    -- Jump with keys
    'easymotion/vim-easymotion',

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


    -- ----------------------------------- GIT ---------------------------------- --
    -- git signts (required by something i think)
    'lewis6991/gitsigns.nvim',
    -- git diff
    "sindrets/diffview.nvim",

    -- --------------------------------- Splits --------------------------------- --
    -- Move splits
    'sindrets/winshift.nvim',
    -- Resize splits
    'mrjones2014/smart-splits.nvim',

    -- -------------------------------- Terminal -------------------------------- --
    -- Toggle terminal
    { "akinsho/toggleterm.nvim", version = '*' },

    -- ------------------------------- Utilities -------------------------------- --
    -- Color picker
    'ziontee113/color-picker.nvim',
    -- Colored background on #xxxxxx colors
    'NvChad/nvim-colorizer.lua',
    -- cool smart surrounding
    'tpope/vim-surround',
    -- visit links
    'xiyaowong/link-visitor.nvim',
    -- Toggle tags
    'nguyenvukhang/nvim-toggler',
    -- Move lines and characters
    'fedepujol/move.nvim',

    -- ------------------------------- Vim autos -------------------------------- --
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

    -- ---------------------------------- Misc ---------------------------------- --
    -- dashboard
    'goolord/alpha-nvim',
    -- Sudo edit/save
    'lambdalisue/suda.vim',
    -- Draw boxes
    'jbyuki/venn.nvim',
    -- Hacker scratchpad
    'metakirby5/codi.vim',
})

