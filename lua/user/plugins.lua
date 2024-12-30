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
    use({ "wbthomason/packer.nvim", commit = "00ec5adef58c5ff9a07f11f45903b9dbbaa1b422" })
    use({ "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" }) -- Useful lua functions used by lots of plugins
    use({ "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" }) -- Autopairs, integrates with both cmp and treesitter
    use({ "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" })

    use "ryanoasis/vim-devicons"
    use({ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" })

    --use({ "akinsho/bufferline.nvim", commit = "c78b3ecf9539a719828bca82fc7ddb9b3ba0c353" })
    --use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
    --use({ "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" })
    --use({ "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" })
    --use({ "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" })
    --use({ "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" })
    --use({ "lukas-reineke/indent-blankline.nvim", commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" })
    --use({ "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" })
    use({ "akinsho/bufferline.nvim" })
    use({ "moll/vim-bbye" })
    use({ "nvim-lualine/lualine.nvim" })
    use({ "akinsho/toggleterm.nvim" })
    use({ "ahmedkhalf/project.nvim" })
    use({ "lewis6991/impatient.nvim" })
    --use({ "lukas-reineke/indent-blankline.nvim"})
    use({ "goolord/alpha-nvim" })
    use("folke/which-key.nvim")
    use("rcarriga/nvim-notify")

    -- debug
    use("mfussenegger/nvim-dap")
    use { "leoluz/nvim-dap-go", requires = { "mfussenegger/nvim-dap" } }
    --use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }
    use 'ray-x/go.nvim'
    use 'ray-x/guihua.lua' -- recommended if need floating window support

    -- Colorschemes
    use({ "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" })
    use("lunarvim/darkplus.nvim")
    use("projekt0n/github-nvim-theme")

    -- Telescope
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-ui-select.nvim"
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim

    -- commenting
    use({ "numToStr/Comment.nvim" }) --, commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" })


    ---- Treesitter
    --use({
    --    "nvim-treesitter/nvim-treesitter",
        --commit = "cc360a9beb1b30d172438f640e2c3450358c4086"
        --commit = "b401b7423d18c78371c5ff1a5f8d3c14292b2047" -- v0.8.5.2
        --commit = "63260da18bf273c76b8e2ea0db84eb901cab49ce" -- v0.9.1
        --commit = "f197a15b0d1e8d555263af20add51450e5aaa1f0"
    --})

    -- Git
    use({ "lewis6991/gitsigns.nvim" })

    -- Markdown Preview
    --use "npxbr/glow.nvim"
    use { "ellisonleao/glow.nvim", config = function() require("glow").setup() end }
    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn["mkdp#util#install"]() end
    }
    use 'mracos/mermaid.vim'

    -- tag surrounding
    --use({ "kylechui/nvim-surround",
    --    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    --})

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        requires = {
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            { 'sago35/tinygo.vim' },

            -- References
            --{ 'VidocqH/lsp-lens.nvim' }
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        }
    }

    -- json schema scrapper
    use 'b0o/SchemaStore.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
