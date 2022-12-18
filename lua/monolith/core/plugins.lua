-- Plugin loading

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
    "BufWritePost",
    { command = "source <afile> | PackerCompile", group = packer_group, pattern = "plugins.lua" }
)

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end
vim.api.nvim_command("packadd packer.nvim")

require('packer').startup({ function(use)
    -- ---------------------------- Package managers ---------------------------- --
    -- Main package manager
    use 'wbthomason/packer.nvim'
    -- LSP package manager
    use 'williamboman/mason.nvim'

    -- -------------------------------- Libraries ------------------------------- --
    -- Async code
    use 'lewis6991/impatient.nvim'
    -- Async rulez
    use 'tpope/vim-dispatch'
    -- > All the lua functions I don't want to write twice.
    use 'nvim-lua/plenary.nvim'
    -- web icons
    use 'kyazdani42/nvim-web-devicons'
    -- easily parse the command inputted by users
    use 'winston0410/cmd-parser.nvim'
    -- ui components
    use 'MunifTanjim/nui.nvim'
    -- py
    use 'roxma/vim-hug-neovim-rpc'
    -- yarp
    use 'roxma/nvim-yarp'
    -- cp
    use 'nixprime/cpsm'

    -- --------------------------------- Themes --------------------------------- --
    use 'morhetz/gruvbox'
    use 'luisiacc/gruvbox-baby'
    use 'almo7aya/neogruvbox.nvim'
    use 'savq/melange'
    use 'catppuccin/nvim'
    use 'folke/tokyonight.nvim'
    use 'elvessousa/sobrio'
    use 'yonlu/omni.vim'

    -- ------------------------------ File managers ----------------------------- --
    use 'nvim-telescope/telescope.nvim'
    -- extensions:
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'fannheyward/telescope-coc.nvim'
    use 'nvim-telescope/telescope-vimspector.nvim'
    use 'chip/telescope-software-licenses.nvim'
    use 'crispgm/telescope-heading.nvim'
    use 'nvim-telescope/telescope-packer.nvim'
    use 'nvim-telescope/telescope-symbols.nvim'
    use 'zane-/howdoi.nvim'
    use 'axieax/urlview.nvim'
    -- creates telescope pickers
    use 'axkirillov/easypick.nvim'
    -- project manager
    use "ahmedkhalf/project.nvim"

    -- -------------------------------- Trees ----------------------------------- --
    -- file tree
    use 'nvim-tree/nvim-tree.lua'
    -- undo tree
    use 'mbbill/undotree'
    -- sidebar
    use 'sidebar-nvim/sidebar.nvim'
    -- sidebar dap breakpoints
    use 'sidebar-nvim/sections-dap'

    -- ----------------------------------- LSP ---------------------------------- --
    -- Configs for the Nvim LSP client (:help lsp)
    use 'neovim/nvim-lspconfig'
    -- mason-lspconfig bridges mason.nvim with the lspconfig plugin
    use 'williamboman/mason-lspconfig.nvim'
    -- lsp but formatting
    use 'jose-elias-alvarez/null-ls.nvim'
    -- mason integration
    use 'jayp0521/mason-null-ls.nvim'
    -- many cool features like hover diagnostic    
    use 'glepnir/lspsaga.nvim'
    -- nvim-dap is a Debug Adapter Protocol client implementation
    use 'mfussenegger/nvim-dap'
    -- dap ui
    use 'rcarriga/nvim-dap-ui'
    -- dap auto-setup
    use 'jayp0521/mason-nvim-dap.nvim'
    -- parser
    use 'nvim-treesitter/nvim-treesitter'
    -- linter
    use 'mfussenegger/nvim-lint'
    -- A completion engine plugin for neovim written in Lua
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    -- Popup snippets
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    -- Auto-create colorscheme for missing format colors
    use 'folke/lsp-colors.nvim'
    -- Auto-close brackets
    use 'windwp/nvim-autopairs'
    -- json chemas
    use 'b0o/schemastore.nvim'
    -- Show function signature
    use 'ray-x/lsp_signature.nvim'
    -- Show icons in snippets
    use 'onsails/lspkind.nvim'
    -- Nvim lua api
    use 'folke/neodev.nvim'

    -- ------------------------------- Formatting ------------------------------- --
    -- Toggle comments
    use 'numToStr/Comment.nvim'
    -- Formatter runner
    use 'lukas-reineke/lsp-format.nvim'
    -- Comment frame
    use 's1n7ax/nvim-comment-frame'
    -- Alisgn text
    use 'junegunn/vim-easy-align'

    -- ----------------------------------- GUI ---------------------------------- --
    -- powerline
    use 'nvim-lualine/lualine.nvim'
    -- Command suggestions
    use 'gelguy/wilder.nvim'

    -- notification engine
    use 'rcarriga/nvim-notify'
    -- [WIP] An implementation of the Popup API from vim in Neovim
    use 'nvim-lua/popup.nvim'

    -- [0/10] /in -- Display number of search matches
    use 'google/vim-searchindex'
    -- range hightlight (:10,15)
    use 'winston0410/range-highlight.nvim'
    -- Colored background on #xxxxxx colors
    use 'NvChad/nvim-colorizer.lua'

    -- tab management
    use 'nanozuki/tabby.nvim'
    -- scrollbar
    use 'petertriho/nvim-scrollbar'
    -- git signts
    use 'lewis6991/gitsigns.nvim'
    -- better search
    use 'kevinhwang91/nvim-hlslens'

    -- lsp progressbar
    use 'j-hui/fidget.nvim'

    -- Move splits
    use 'sindrets/winshift.nvim'
    -- Resize splits
    use 'mrjones2014/smart-splits.nvim'

    -- Toggle terminal
    use { "akinsho/toggleterm.nvim", tag = '*' }

    -- dashboard
    use 'goolord/alpha-nvim'

    -- remove background
    use 'tribela/vim-transparent'

    -- minimap
    use { 'echasnovski/mini.map', branch = 'stable' }
    -- -------------------------------- PowerVim -------------------------------- --
    -- Color picker
    use 'ziontee113/color-picker.nvim'

    -- cool smart surrounding, think about it
    use 'tpope/vim-surround'
    -- visit links
    use 'xiyaowong/link-visitor.nvim'
    -- use tasks
    use 'pianocomposer321/yabs.nvim'

    -- Draw boxes
    use 'jbyuki/venn.nvim'

    -- Create plugins
    use 'anuvyklack/hydra.nvim'

    -- TodoTree
    use 'AmeerTaweel/todo.nvim'

    -- Better quickfix
    use 'https://gitlab.com/yorickpeterse/nvim-pqf.git'
    -- Goto quickfix files
    use 'yssl/QFEnter'

    -- Preview markdown
    use 'ellisonleao/glow.nvim'
    -- Hacker scratchpad
    use 'metakirby5/codi.vim'

    -- Jump with keys
    use 'easymotion/vim-easymotion'

    -- Toggle tags
    use 'nguyenvukhang/nvim-toggler'

    -- Session manager
    use 'natecraddock/sessions.nvim'
    -- jj to exit
    use 'jdhao/better-escape.vim'
    -- remember last edited line
    use 'ethanholz/nvim-lastplace'

    -- mkdir -r
    use 'jghauser/mkdir.nvim'
    -- clipboard
    use 'AckslD/nvim-neoclip.lua' 

    -- Project-wide rename
    use 'windwp/nvim-spectre'

    -- Preview markdown
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    if packer_bootstrap then
        require("packer").sync()
    end
end,
    config = {
        display = {
            open_fn = require("packer.util").float,
        },
        profile = {
            enable = true,
            threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
        },
    },
})

--[[
    CocList:
        coc-prettier
        coc-pairs
        coc-json
        coc-dlang
]]

--[[
    TO CONSIDER:
    https://github.com/pwntester/octo.nvim
    https://github.com/ray-x/sad.nvim
]]
