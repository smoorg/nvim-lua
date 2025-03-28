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

local newmappings = {
    { "T", group = "Terminal", nowait = true, remap = false },
    { "Tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", nowait = true, remap = false },
    { "Th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal", nowait = true, remap = false },
    { "Tn", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Node", nowait = true, remap = false },
    { "Tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python", nowait = true, remap = false },
    { "Tt", "<cmd>lua _HTOP_TOGGLE()<cr>", desc = "Htop", nowait = true, remap = false },
    { "Tu", "<cmd>lua _NCDU_TOGGLE()<cr>", desc = "NCDU", nowait = true, remap = false },
    { "Tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical", nowait = true, remap = false },
    { "W", "<cmd>w !sudo -A tee %<CR>", desc = "Save (sudo)", nowait = true, remap = false },
    { "a", "<cmd>Alpha<cr>", desc = "Alpha", nowait = true, remap = false },
    { "b", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Buffers", nowait = true, remap = false },
    { "c", "<cmd>Bdelete!<CR>", desc = "Close Buffer", nowait = true, remap = false },
    { "d", group = "DAP", nowait = true, remap = false },
    { "dO", "<cmd>dap.step_out<CR>", desc = "Step Out", nowait = true, remap = false },
    { "db", "<cmd>dap.toggle_breakpoint<CR>", desc = "Toggle Breakpoint", nowait = true, remap = false },
    { "dc", "<cmd>dap.continue<CR>", desc = "Continue", nowait = true, remap = false },
    { "di", "<cmd>dap.step_into<CR>", desc = "Step Into", nowait = true, remap = false },
    { "dl", "<cmd>dap.run_last<CR>", desc = "Run Last", nowait = true, remap = false },
    { "do", "<cmd>dap.step_over<CR>", desc = "Step Over", nowait = true, remap = false },
    { "dr", "<cmd>dap.repl.open<CR>", desc = "Open", nowait = true, remap = false },
    { "dw", group = "Widgets", nowait = true, remap = false },
    { "dwf", "<cmd>dap.ui.widgets.centered_float(dap.ui.widgets.frames)<CR>", desc = "Frames", nowait = true, remap = false },
    { "dwh", "<cmd> dap.ui.widgets.hover()<CR>", desc = "Hover", nowait = true, remap = false },
    { "dwp","<cmd>dap.ui.widgets.preview()<CR>", desc = "Preview", nowait = true, remap = false },
    { "dws", "<cmd>dap.ui.widgets.centered_float(dap.ui.widgets.scopes)<CR>", desc = "Frames", nowait = true, remap = false },
    { "e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer", nowait = true, remap = false },
    { "f", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Find files", nowait = true, remap = false },
    { "g", group = "Git", nowait = true, remap = false },
    { "gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset Buffer", nowait = true, remap = false },
    { "gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
    { "gc", "<cmd>Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
    { "gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff", nowait = true, remap = false },
    { "gf", "<cmd>Telescope git_files<cr>", desc = "Git Files", nowait = true, remap = false },
    { "gj", "<cmd>Gitsigns next_hunk<cr>", desc = "Next Hunk", nowait = true, remap = false },
    { "gk", "<cmd>Gitsigns prev_hunk<cr>", desc = "Prev Hunk", nowait = true, remap = false },
    { "gl", "<cmd>Gitsigns blame_line<cr>", desc = "Blame", nowait = true, remap = false },
    { "gm", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
    { "gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk", nowait = true, remap = false },
    { "gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk", nowait = true, remap = false },
    { "gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk", nowait = true, remap = false },
    { "gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk", nowait = true, remap = false },
    { "h", "<cmd>nohlsearch<CR>", desc = "No Highlight", nowait = true, remap = false },
    { "l", group = "LSP", nowait = true, remap = false },
    { "lI", "<cmd>LspInfo<cr>", desc = "Info", nowait = true, remap = false },
    { "lL", "<cmd>LspRestart<cr>", desc = "Reset", nowait = true, remap = false },
    { "lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = true, remap = false },
    { "lQ",  "<cmd>vim.diagnostic.setloclist<CR>", desc = "Quickfix", nowait = true, remap = false },
    { "lR",  "<cmd>vim.lsp.buf.references<CR>", desc = "References", nowait = true, remap = false },
    { "la",  "<cmd>vim.lsp.buf.code_action<CR>", desc = "Code Action", nowait = true, remap = false },
    { "ld",  "<cmd>vim.lsp.buf.definition<CR>", desc = "Go to definition", nowait = true, remap = false },
    { "lf",  "<cmd>vim.lsp.buf.format<CR>", desc = "Format", nowait = true, remap = false },
    { "lgj", "<cmd>vim.diagnostic.goto_next<CR>", desc = "Next Diagnostic", nowait = true, remap = false },
    { "lgk", "<cmd>vim.diagnostic.goto_prev<CR>", desc = "Prev Diagnostic", nowait = true, remap = false },
    { "li",  "<cmd>vim.lsp.buf.implementation<CR>", desc = "Go to implementation", nowait = true, remap = false },
    { "lk",  "<cmd>vim.lsp.buf.hover<CR>", desc = "Signature info", nowait = true, remap = false },
    { "ll",  "<cmd>vim.lsp.codelens.run<CR>", desc = "CodeLens Action", nowait = true, remap = false },
    { "lr",  "<cmd>vim.lsp.buf.rename<CR>", desc = "Rename", nowait = true, remap = false },
    { "ly",  "<cmd>vim.lsp.buf.references<CR>", desc = "Go to declaration", nowait = true, remap = false },
    { "lgw", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics", nowait = true, remap = false },
    { "lgd", "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", desc = "Buffer Diagnostics", nowait = true, remap = false },
    { "lm", "<cmd>Mason<cr>", desc = "Installer Info", nowait = true, remap = false },
    { "ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", nowait = true, remap = false },
    { "n", group = "Utils", nowait = true, remap = false },
    { "nm", "<cmd>Glow<cr>", desc = "Markdown Preview", nowait = true, remap = false },
    { "p", group = "Packer", nowait = true, remap = false },
    { "pS", "<cmd>PackerStatus<cr>", desc = "Status", nowait = true, remap = false },
    { "pc", "<cmd>PackerCompile<cr>", desc = "Compile", nowait = true, remap = false },
    { "pi", "<cmd>PackerInstall<cr>", desc = "Install", nowait = true, remap = false },
    { "ps", "<cmd>PackerSync<cr>", desc = "Sync", nowait = true, remap = false },
    { "pu", "<cmd>PackerUpdate<cr>", desc = "Update", nowait = true, remap = false },
    { "q", "<cmd>q!<CR>", desc = "Quit", nowait = true, remap = false },
    { "s", group = "Search", nowait = true, remap = false },
    { "sC", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
    { "sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
    { "sR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
    { "sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
    { "sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
    { "sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
    { "sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
    { "sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
    { "t", group = "Telescope", nowait = true, remap = false },
    { "to", "<cmd>Telescope oldfiles<cr>", desc = " Recently used files", nowait = true, remap = false },
    { "tp", "<cmd>Telescope projects<cr>", desc = "Projects", nowait = true, remap = false },
    { "tt", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Find Text", nowait = true, remap = false },
    { "w", "<cmd>w!<CR>", desc = "Save", nowait = true, remap = false },
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
        c = { dap.continue, "Continue" },
        o = { dap.step_over, "Step Over" },
        i = { dap.step_into, "Step Into" },
        O = { dap.step_out, "Step Out" },
        r = { dap.repl.open, "Open" },
        l = { dap.run_last, "Run Last" },
        b = { dap.toggle_breakpoint, "Toggle Breakpoint" },
        C = { dap.clear_breakpoint, "Clear Breakpoints" },
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
