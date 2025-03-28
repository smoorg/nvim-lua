local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

mason.setup()

mason_lspconfig.setup({
    ensure_installed = {
        'lua_ls',
        'zls',
        'solargraph',
        'gopls',
        'jsonls',
        'terraformls'
    }
})

mason_lspconfig.setup_handlers({
    function(server)
        lspconfig[server].setup {
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

                --on_attach = function(bufnr)
                --    local opts = { buffer = bufnr }
                --end
            end,
        }
        lspconfig["solargraph"].setup {
            completion  = true,
            definitions = true,
            diagnostics = true,
            folding     = true,
            formatting  = true,
            hover       = true,
            references  = true,
            rename      = true,
            symbols     = true,
            useBundler  = true,
        }
    end
})
