local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})
-- Install your plugins here
return packer.startup(function(use)
    -- Have packer manage itself
    use({ "wbthomason/packer.nvim" })
    use({ "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" }) -- Useful lua functions used by lots of plugins
    use({ "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" }) -- Autopairs, integrates with both cmp and treesitter
    use({ "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" })

    use "ryanoasis/vim-devicons"
    use({ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" })

    use({ "akinsho/bufferline.nvim" })
    use({ "moll/vim-bbye" })
    use({ "nvim-lualine/lualine.nvim" })
    use({ "akinsho/toggleterm.nvim" })
    use({ "ahmedkhalf/project.nvim" })
    use({ "lewis6991/impatient.nvim" })
    use({ "goolord/alpha-nvim" })
    use("folke/which-key.nvim")
    use("rcarriga/nvim-notify")

    -- todo list
    use { 'arnarg/todotxt.nvim', requires = { 'MunifTanjim/nui.nvim' } }

    -- debug
    use "mfussenegger/nvim-dap"
    use { "leoluz/nvim-dap-go", requires = { "mfussenegger/nvim-dap" } }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }
    use 'ray-x/go.nvim'
    use 'ray-x/guihua.lua' -- recommended if need floating window support

    -- Colorschemes
    use({ "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" })
    use "lunarvim/darkplus.nvim"
    use "projekt0n/github-nvim-theme"
    use 'UtkarshVerma/molokai.nvim'
    use { 'metalelf0/jellybeans-nvim', requires = { 'rktjmp/lush.nvim' } }
    use "neko-night/nvim"

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use "nvim-telescope/telescope-ui-select.nvim"
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim

    -- commenting
    use({ "numToStr/Comment.nvim" }) --, commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" })

    -- Git
    use({ "lewis6991/gitsigns.nvim" })

    -- Markdown Preview
    --use "npxbr/glow.nvim"
    use { "ellisonleao/glow.nvim", config = function() require("glow").setup() end }
    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn["mkdp#util#install"]() end
    }

    -- support for mermaid (charts language) autocompletion
    use 'mracos/mermaid.vim'

    -- tag surrounding
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    })

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        requires = {
            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',

            'sago35/tinygo.vim',

            -- References
            'VidocqH/lsp-lens.nvim',
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        }
    }

    -- json schema scrapper
    use 'b0o/SchemaStore.nvim'

    use 'nvim-treesitter/nvim-treesitter'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
