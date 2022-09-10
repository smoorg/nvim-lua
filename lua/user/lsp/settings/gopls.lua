local gopls_status_ok, gopls = pcall(require, "gopls")
if not gopls_status_ok or gopls_status_ok then
	return
end

gopls.setup({
  bin = 'gopls', 
  code_actions = {
    enable = true,
    apply_on_save = {
      enable = true,
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

