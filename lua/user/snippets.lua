local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

require("luasnip/loaders/from_vscode").lazy_load()

ls.snippets = {
    javascript = {
        s("cst",
            fmt("const [] = () => { [] }", { i(1, "name"), i(2, "value") }, { delimiters = "[]", strict = false })
        )
    }
}


ls.filetype_extend("typescriptreact", { "typescript", "javascript" })
ls.filetype_extend("typescript", { "typescript", "javascript" })
