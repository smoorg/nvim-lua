local status_ok, comment = pcall(require, "Comment")
if not status_ok then
    return
end

comment.setup {
    ---Add a space b/w comment and the line
    padding = false,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment -> empty lines
    ignore = '^$',
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = 'gc',
        ---Block-comment toggle keymap
        block = 'gb',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    --opleader = {
    --    ---Line-comment keymap
    --    line = 'gcc',
    --    ---Block-comment keymap
    --    block = 'gbc',
    --},
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = false,
    },
    ---Function to call before comment
    ---pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    ---Function to call after (un)comment
    ---post_hook = nil,
}
