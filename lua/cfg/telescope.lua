require('telescope').setup({
    defaults = {
        layout_strategy = 'bottom_pane',
        layout_config = {
            height = 25,
        },
        border = true,
        sorting_strategy = 'ascending',
    },
    pickers = {
        find_files = {
            theme = 'ivy',
        },
        live_grep = {
            theme = 'ivy',
        },
        buffers = {
            theme = 'ivy',
        },
        help_tags = {
            theme = 'ivy',
        },
        oldfiles = {
            theme = 'ivy',
        },
        commands = {
            theme = 'ivy',
        },
        keymaps = {
            theme = 'ivy',
        },
    },
})

