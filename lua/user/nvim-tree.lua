local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    renderer = {
        root_folder_modifier = ":t",
        highlight_opened_files = "all",
        indent_markers = {
            enable = true
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    actions = {
        change_dir = {
            enable = false,
            restrict_above_cdw = true,
        },
    },
    view = {
        adaptive_size = true,
        side = "left",
        relativenumber = true,
        signcolumn = "yes",
        mappings = {
            list = {
                { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
                { key = "h", cb = tree_cb "close_node" },
                { key = "v", cb = tree_cb "vsplit" },
            },
        },
    },
}
