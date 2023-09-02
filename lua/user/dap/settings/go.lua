local dap, dapui = require("dap"), require("dapui")

dap.adapters.delve = {
    type = 'server',
    port = '${port}',
    executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:${port}' },
    }
}

--dap.adapters.go = {
--    type = 'executable',
--    command = 'node',
--    --args = { os.getenv('HOME') .. '/dev/golang/vscode-go/dist/debugAdapter.js' },
--}

dap.set_log_level = "TRACE"

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    --{
    --    type = "go",
    --    name = "Debug",
    --    request = "launch",
    --    program = "${file}",
    --    dlvToolPath = vim.fn.exepath('dlv')
    --}
    {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}"
    },
    {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}"
    },
    -- works with go.mod packages and sub packages
    {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}"
    }
}

--dap.listeners.after.event_initialized["dapui_config"] = function()
--    dapui.open()
--end
--dap.listeners.before.event_terminated["dapui_config"] = function()
--    dapui.close()
--end
--dap.listeners.before.event_exited["dapui_config"] = function()
--    dapui.close()
--end

--require("dap-go").setup()
require('go').setup()
