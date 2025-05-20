local dap = require("dap")

dap.adapters.codelldb = {
    type = 'server',
    port = "13299",
    executable = {
        command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
        args = { "--port", "13299" },
    }
}
