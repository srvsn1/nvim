local events = require('events')

-- Load which-key synchronously
local wk = require('which-key')
wk.setup()

-- General keymaps
wk.add({
    { "<leader>y", '"+y', desc = "Yank to System Clipboard", mode = { "n", "v" } },
})

events.RegisterPostEvent(events.Event.Oil, function()
    wk.add({
        { "-", "<cmd>Oil<cr>", desc = "Open Oil File Explorer" },
    })
end)

events.RegisterPostEvent(events.Event.Telescope, function()
    local builtin = require('telescope.builtin')

    wk.add({
        { "<leader>f", group = "Telescope Find" },
        { "<leader>ff", builtin.find_files, desc = "Find Files" },
        { "<leader>fg", builtin.live_grep, desc = "Live Grep" },
        { "<leader>fb", builtin.buffers, desc = "Buffers" },
        { "<leader>fh", builtin.help_tags, desc = "Help Tags" },
        { "<leader>fr", builtin.oldfiles, desc = "Recent Files" },
        { "<leader>fc", builtin.commands, desc = "Commands" },
        { "<leader>fk", builtin.keymaps, desc = "Keymaps" },
        { "<leader>fd", builtin.diagnostics, desc = "Diagnostic" },
    })
end)


