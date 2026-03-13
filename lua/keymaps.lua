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