local todo = require('todotxt-nvim')

todo.setup({
    todo_file = "~/Documents/todo.txt",
    -- Keymap used in sidebar split
    keymap = {
        quit = "q",
        toggle_metadata = "m",
        delete_task = "dd",
        complete_task = "<space>",
        edit_task = "ee",
    },
})
