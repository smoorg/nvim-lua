local which_key = require("which-key")
local dap = require('dap')

local setup = {
    plugins = {
        marks = false,        -- shows a list of your marks on ' and `
        registers = false,    -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false,      -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true,       -- default bindings on <c-w>
            nav = true,           -- misc bindings to work with windows
            z = true,             -- bindings for folds, spelling and others prefixed with z
            g = true,             -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded",       -- none, single, double, shadow
        position = "bottom",      -- bottom, top
        margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 },                                           -- min and max height of the columns
        width = { min = 20, max = 50 },                                           -- min and max width of the columns
        spacing = 3,                                                              -- spacing between columns
        align = "left",                                                           -- align columns left, center or right
    },
    ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true,                                                             -- show help message on the command line when the popup is visible
    triggers = "auto",                                                            -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
    a = { "<cmd>Alpha<cr>", "Alpha" },
    b = {
        "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "Buffers",
    },
    e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    w = { "<cmd>w!<CR>", "Save" },
    W = { "<cmd>w !sudo -A tee %<CR>", "Save (sudo)" },
    q = { "<cmd>q!<CR>", "Quit" },
    c = { "<cmd>Bdelete!<CR>", "Close Buffer" },
    h = { "<cmd>nohlsearch<CR>", "No Highlight" },
    f = {
        "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "Find files",
    },

    p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    t = {
        name = "Telescope",
        t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
        p = { "<cmd>Telescope projects<cr>", "Projects" },
        o = { "<cmd>Telescope oldfiles<cr>", "  Recently used files" },
    },
    g = {
        name = "Git",
        j = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
        k = { "<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk" },
        l = { "<cmd>Gitsigns blame_line<cr>", "Blame" },
        p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
        r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
        R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
        s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
        f = { "<cmd>Telescope git_files<cr>", "Git Files" },
        c = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        m = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk",
        },
        d = {
            "<cmd>Gitsigns diffthis HEAD<cr>",
            "Diff",
        },
    },
    d = {
        name = "DAP",
        c = { "<cmd>DapContinue<CR>", "Continue" },
        o = { "<cmd>DapStepOver<CR>", "Step Over" },
        i = { "<cmd>DapStepInto<CR>", "Step Into" },
        O = { "<cmd>DapStepOut<CR>", "Step Out" },
        --r = { "<cmd>DapRepl.open, "Open" },
        --l = { "<cmd>DapRun_last, "Run Last" },
        b = { "<cmd>DapToggleBreakpoint<CR>", "Toggle Breakpoint" },
        C = { "<cmd>DapClearBreakpoint<CR>", "Clear Breakpoints" },
        w = {
            name = "Widgets",
            h = { "<cmd>lua require('dap.ui.widgets').hover()<cr>", "Hover" },
            p = { "<cmd>lua require('dap.ui.widgets').preview()<cr>", "Preview" },
            f = { (
                function()
                    local widgets = require('dap.ui.widgets')
                    widgets.centered_float(widgets.frames)
                end),
                "Frames"
            },
            s = { (
                function()
                    local widgets = require('dap.ui.widgets')
                    widgets.centered_float(widgets.scopes)
                end),
                "Frames"
            },
        }
    },
    l = {
        name = "LSP",
        -- Diagnostics
        a = { vim.lsp.buf.code_action, "Code Action" },
        l = { vim.lsp.codelens.run, "CodeLens Action" },
        i = { vim.lsp.buf.implementation, "Go to implementation" },
        d = { vim.lsp.buf.definition, "Go to definition" },
        y = { vim.lsp.buf.declaration, "Go to declaration" },
        R = { vim.lsp.buf.references, "References" },
        k = { vim.lsp.buf.hover, "Signature info" },

        -- Refactor
        r = { vim.lsp.buf.rename, "Rename" },
        f = { vim.lsp.buf.format, "Format" },
        Q = { vim.diagnostic.setloclist, "Quickfix" },

        -- Manage
        I = { "<cmd>LspInfo<cr>", "Info" },
        L = { "<cmd>LspRestart<cr>", "Reset" },
        m = { "<cmd>Mason<cr>", "Installer Info" },

        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },

        g = {
            j = { vim.diagnostic.goto_next, "Next Diagnostic" },
            k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
            d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
            w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        }
    },
    n = {
        name = "Utils",
        m = { "<cmd>Glow<cr>", "Markdown Preview" }
    },
    s = {
        name = "Search",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
    },

    T = {
        name = "Terminal",
        n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
        u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
        t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
        p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
        f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
        h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
        v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    },
}

which_key.setup(setup)
which_key.register(mappings, opts)
