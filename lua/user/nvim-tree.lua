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
    update_cwd = true,
    renderer = {
        root_folder_modifier = ":t",
        highlight_opened_files = "all",
        indent_markers = {
            enable = true
        },
        icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            --glyphs = {
            --    default = ">",
            --    symlink = "",
            --    folder = {
            --        arrow_closed = ">",
            --        arrow_open = "∨",
            --        default = "📁",
            --        open = "📁",
            --        empty = "📁",
            --        empty_open = "",
            --        symlink = "",
            --        symlink_open = "",
            --    },
            --    git = {
            --        unstaged = "✗",
            --        staged = "✓",
            --        unmerged = "",
            --        renamed = "➜",
            --        untracked = "★",
            --        deleted = "",
            --        ignored = "◌",
            --    },
            --},
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = false,
        icons = {
            hint = ">",
            info = "",
            warning = "",
            error = "",
        },
    },
    actions = {
        change_dir = {
            enable = false,
            global = true,
            restrict_above_cwd = true,
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
                { key = "h",                  cb = tree_cb "close_node" },
                { key = "v",                  cb = tree_cb "vsplit" },
            },
        },
    },
}
