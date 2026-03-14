-- ============================================================================
-- LSP Configuration
-- ============================================================================
-- General LSP setup and UI configuration.
-- Language-specific configs are in lua/languages/
-- Keymaps are in lua/keymaps.lua (attached via LspAttach event)
-- ============================================================================

-- Load language-specific configurations
require("languages")

-- Enable configured language servers
vim.lsp.enable({ "lua_ls", "rust-analyzer", "taplo" })

-- LSP UI Configuration
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Diagnostic signs
local signs = { Error = "✘", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

