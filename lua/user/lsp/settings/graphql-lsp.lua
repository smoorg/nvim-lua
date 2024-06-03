local lspconfig = require("lspconfig")

lspconfig.graphql.setup ({
    filetypes = { "typescript", "typescriptreact", "graphql" },
    root_dir = lspconfig.util.root_pattern(".graphqlconfig", ".graphqlrc", "package.json"),
    flags = {
        debounce_text_changes = 150,
    },
    code_actions = {
        enable = true,
        apply_on_save = {
            enable = false,
            types = { "problem", "layout", "directive" }, -- "directive", "problem", "suggestion", "layout"
        },
        disable_rule_comment = {
            enable = true,
            location = "separate_line", -- or `same_line`
        },
    },
    diagnostics = {
        enable = true,
        report_unused_disable_directives = true,
        run_on = "type", -- or `save`
    },
})
