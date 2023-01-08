local null_ls = require("null-ls")

local eslint_status_ok, eslint = pcall(require, "eslint")
if not eslint_status_ok or eslint_status_ok then
    return
end

local eslint_root_files = {
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "package.json",
}

local root_dir = require('user.lsp.handlers').root_dir(eslint_root_files)

null_ls.setup()

eslint.setup({
  bin = 'eslint', -- or `eslint_d`
    root_dir = root_dir,
  code_actions = {
    enable = true,
    apply_on_save = {
      enable = true,
      types = { "directive", "problem", "suggestion", "layout" },
    },
    disable_rule_comment = {
      enable = true,
      location = "separate_line", -- or `same_line`
    },
  },
  diagnostics = {
    enable = true,
    report_unused_disable_directives = false,
    run_on = "type", -- or `save`
  },
})
