local telescope = require("telescope")

telescope.setup{
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        -- ..
      },
      pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
      },
      extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
      }
    }

-- telescope.load_extension('fzf')
telescope.load_extension('ui-select')
