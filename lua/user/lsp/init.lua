local lspconfig = vim.lsp.config
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

mason.setup()

mason_lspconfig.setup({
    ensure_installed = {
        'lua_ls',
        'zls',
        'gopls',
        'jsonls',
        'terraformls'
    },
    automatic_enable = true
})


mason_lspconfig.setup({
    function(server)
        lspconfig[server].settings {
            --capabilities = capabilities,
            on_init = function(bufnr)
                local opts = { buffer = bufnr }
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

            end,
        }
    end
})

require "user.lsp.lua_config"
