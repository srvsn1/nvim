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

-- CopilotChat keymaps
wk.add({
    { "<leader>a", group = "Copilot Chat" },
    { "<leader>ai", "<cmd>CopilotChatInline<cr>", desc = "Inline Chat", mode = { "n", "v" } },
    { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain Code", mode = { "n", "v" } },
    { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review Code", mode = { "n", "v" } },
    { "<leader>af", "<cmd>CopilotChatFix<cr>", desc = "Fix Code", mode = { "n", "v" } },
    { "<leader>ao", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize Code", mode = { "n", "v" } },
    { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate Tests", mode = { "n", "v" } },
    { "<leader>ad", "<cmd>CopilotChatDocs<cr>", desc = "Generate Docs", mode = { "n", "v" } },
    { "<leader>ac", "<cmd>CopilotChat<cr>", desc = "Open Chat", mode = { "n", "v" } },
    { "<leader>ap", function()
        vim.ui.input({ prompt = "Copilot> " }, function(input)
          if input and input ~= "" then
            require('CopilotChat').ask(input)
          end
        end)
      end, desc = "Quick Prompt", mode = { "n", "v" } },
})

events.RegisterPostEvent(events.Event.Lsp, function()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            -- Core LSP keymaps
            wk.add({
                { "gd", vim.lsp.buf.definition, desc = "Go to Definition", buffer = bufnr },
                { "gD", vim.lsp.buf.declaration, desc = "Go to Declaration", buffer = bufnr },
                { "gi", vim.lsp.buf.implementation, desc = "Go to Implementation", buffer = bufnr },
                { "gt", vim.lsp.buf.type_definition, desc = "Go to Type Definition", buffer = bufnr },
                { "K", vim.lsp.buf.hover, desc = "Hover Documentation", buffer = bufnr },
                { "gr", vim.lsp.buf.references, desc = "Go to References", buffer = bufnr },
                { "<leader>rn", vim.lsp.buf.rename, desc = "Rename Symbol", buffer = bufnr },
                { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", buffer = bufnr },
                { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format Document", buffer = bufnr },
            })

            -- Diagnostic keymaps
            wk.add({
                { "[d", vim.diagnostic.goto_prev, desc = "Previous Diagnostic", buffer = bufnr },
                { "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic", buffer = bufnr },
                { "<leader>d", vim.diagnostic.open_float, desc = "Show Diagnostic", buffer = bufnr },
            })

            -- Rust-specific keymaps
            if client and client.name == "rust_analyzer" then
                wk.add({
                    { "<leader>r", group = "Rust", buffer = bufnr },
                    { "<leader>rc", "<cmd>!cargo check<cr>", desc = "Cargo Check", buffer = bufnr },
                    { "<leader>rb", "<cmd>!cargo build<cr>", desc = "Cargo Build", buffer = bufnr },
                    { "<leader>rr", "<cmd>!cargo run<cr>", desc = "Cargo Run", buffer = bufnr },
                    { "<leader>rt", "<cmd>!cargo test<cr>", desc = "Cargo Test", buffer = bufnr },
                    { "<leader>rw", "<cmd>LspCargoReload<cr>", desc = "Reload Workspace", buffer = bufnr },
                })
            end
        end,
    })
end)


