local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    }

    if server.name == "jsonls" then
        local jsonls_opts = require("user.lsp.settings.jsonls")
        opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    if server.name == "sumneko_lua" then
        local sumneko_opts = require("user.lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server.name == "emmet_ls" then
        local emmetls_opts = require("user.lsp.settings.emmet-ls");
        opts = vim.tbl_deep_extend("force", emmetls_opts, opts);
    end

    if server.name == "null_ls" then
        local nullls_opts = require("user.lsp.settings.null-ls")
        opts = vim.tbl_deep_extend("force", nullls_opts, opts)
    end

    if server.name == "eslint" then
        local eslint_opts = require("user.lsp.settings.eslint")
        opts = vim.tbl_deep_extend("force", eslint_opts, opts)
    end

    if server.name == "clangd" then
        local clangd_opts = require("user.lsp.settings.clangd")
        opts = vim.tbl_deep_extend("force", clangd_opts, opts)
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end
)
