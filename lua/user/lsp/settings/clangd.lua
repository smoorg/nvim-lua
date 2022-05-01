local configs = require 'lspconfig/configs'

local root_files = {
	'Makefile',
  '.clangd',
  '.clang-tidy',
  '.clang-format',
  'compile_commands.json',
  'compile_flags.txt',
  'configure.ac', -- AutoTools
}
local root_dir = require('user.lsp.handlers').root_dir(root_files)

configs.clangd = {
  default_config = {
    cmd = { 'clangd',};
    filetypes = { "c", "cpp", "h", "hpp" },
    root_dir = root_dir,
    settings = {};
  };
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return { capabilities = capabilities }
