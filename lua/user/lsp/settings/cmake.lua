local configs = require 'lspconfig/configs'

local root_files = { 'cmake', 'CMakeLists.txt' }
local root_dir = require('user.lsp.handlers').root_dir(root_files)

local docs_files = { "compile_commands.json", "build" }
local docs_dir = require('user.lsp.handlers').root_dir(docs_files)

configs.cmake = {
    default_config = {
        cmd = { 'cmake' };
        filetypes = { "cmake" },
        root_dir = root_dir,
    };
    docs = {
        description = [[
https://github.com/regen100/cmake-language-server
CMake LSP Implementation
]]       ,
        default_config = {
            root_dir = docs_dir,
        },
    },
}
