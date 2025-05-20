---@diagnostic disable: lowercase-global
local dap = require("dap")

local splitStr = function(inputstr)
    local t = {}
    for str in string.gmatch(inputstr, "([^%s]+)") do
        table.insert(t, str)
    end
    return t
end


dap.configurations.zig = {
    {
        name = "(gba) Launch",
        type = "codelldb",
        request = "launch",
        --type = "cppdbg",
        targetArchitecture = "arm",
        environment = {},
        stopAtEntry = false,
        externalConsole = false,
        miDebuggerServerAddress = "localhost:2345",
        MIMode = "gdb",
        program = function()
            co = coroutine.running()
            if co then
                cb = function(item)
                    coroutine.resume(co, item)
                end
            end
            cb = vim.schedule_wrap(cb)
            vim.ui.select(vim.fn.glob(vim.fn.getcwd() .. '**/zig-out/**/*', false, true), {
                    prompt = "Select executable",
                    kind = "file",
                },
                cb)
            return coroutine.yield()
        end,
        setupCommands = {
            {
                description = "Enable pretty-printing for gdb",
                text = "-enable-pretty-printing",
                ignoreFailures = true
            },
            {
                description = "Set Disassembly Flavor to Intel",
                text = "-gdb-set disassembly-flavor intel",
                ignoreFailures = true
            }
        },
        miDebuggerPath = "arm-none-eabi-gdb", -- Ensure this points to your GDB executable
        linux = {
            miDebuggerPath = "${env:DEVKITARM}/bin/arm-none-eabi-gdb",
            setupCommands = {
                {
                    text = "shell \"mgba\" -g \"${workspaceFolder}/my-game.elf\" &"
                }
            }
        },
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = function()
            return splitStr(vim.fn.input('Args: '))
        end,
    }
}
