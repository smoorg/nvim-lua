local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

local status_ok, handlers = pcall(require,"user.lsp.handlers")
if not status_ok then
    return
end

local root_dir = handlers.root_dir({})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    -- debug = false,
    root_dir = root_dir,
    sources = {
        --formatting.eslint,
        code_actions.eslint,
        diagnostics.eslint,
    },
})
