local configs = require'lspconfig/configs'

configs.emmet_ls = {
  default_config = {
    cmd = {'emmet-ls', '--stdio'};
    filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    root_dir = function()
      return vim.loop.cwd()
    end;
    settings = {};
  };
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return { capabilities = capabilities }
