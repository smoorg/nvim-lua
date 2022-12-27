local configs = require 'lspconfig/configs'
local root_dir = require('user.lsp.handlers').root_dir({})

configs.emmet_ls = {
    default_config = {
        cmd = { 'emmet-ls', '--stdio' };
        filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
        root_dir = root_dir,
        settings = {};
    };
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return { capabilities = capabilities }
