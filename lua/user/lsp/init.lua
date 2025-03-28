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

        lspconfig["lua_ls"].setup {
            diagnostics = {
                globals = { 'vim', 'vim.g' }
            },
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                            -- Depending on the usage, you might want to add additional paths here.
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                })
            end,
            settings = {
                Lua = {}
            }
        }
    end
})
