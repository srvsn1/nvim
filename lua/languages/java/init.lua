-- ============================================================================
-- Java Language Configuration (jdtls 1.49.0)
-- ============================================================================
-- This file contains all Java-specific LSP configuration using eclipse.jdt.ls.
-- Requires: jdtls installed at ~/.jdtls with version 1.49.0
-- Java version: 17
-- To disable Java support, comment out the require in lua/languages/init.lua
-- ============================================================================

local home = vim.fs.normalize(vim.env.HOME)
local jdtls_home = home .. "/.jdtls"
local launcher_jar = vim.fn.glob(jdtls_home .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- Determine OS config directory name
local os_config
local arch = vim.uv.os_uname().machine
if vim.fn.has("mac") == 1 then
	os_config = arch == "arm64" and "config_mac_arm" or "config_mac"
elseif vim.fn.has("unix") == 1 then
	os_config = arch == "aarch64" and "config_linux_arm" or "config_linux"
else
	os_config = "config_win"
end

local config_dir = jdtls_home .. "/" .. os_config

-- Per-project data directory for jdtls workspace
local function get_data_dir(root_dir)
	local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
	return home .. "/.local/share/jdtls-workspace/" .. project_name
end

-- jdtls LSP Configuration
---@type vim.lsp.Config
vim.lsp.config("jdtls", {
	cmd = function(dispatchers, config)
		local root_dir = config.root_dir or vim.fn.getcwd()
		local data_dir = get_data_dir(root_dir)

		local cmd = {
			"java",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xmx1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens", "java.base/java.util=ALL-UNNAMED",
			"--add-opens", "java.base/java.lang=ALL-UNNAMED",
			"-jar", launcher_jar,
			"-configuration", config_dir,
			"-data", data_dir,
		}

		return vim.lsp.rpc.start(cmd, dispatchers, {
			cwd = root_dir,
		})
	end,
	filetypes = { "java" },
	root_markers = {
		"pom.xml",
		"build.gradle",
		"build.gradle.kts",
		"settings.gradle",
		"settings.gradle.kts",
		".git",
	},
	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = "JavaSE-17",
						path = vim.fn.expand("$JAVA_HOME"),
						default = true,
					},
				},
			},
			eclipse = {
				downloadSources = true,
			},
			maven = {
				downloadSources = true,
			},
			signatureHelp = {
				enabled = true,
			},
			contentProvider = {
				preferred = "fernflower",
			},
			completion = {
				favoriteStaticMembers = {
					"org.junit.Assert.*",
					"org.junit.Assume.*",
					"org.junit.jupiter.api.Assertions.*",
					"org.junit.jupiter.api.Assumptions.*",
					"org.junit.jupiter.api.DynamicContainer.*",
					"org.junit.jupiter.api.DynamicTest.*",
					"org.mockito.Mockito.*",
					"org.mockito.ArgumentMatchers.*",
					"org.mockito.Answers.*",
				},
				importOrder = {
					"java",
					"javax",
					"com",
					"org",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
		},
	},
	on_attach = function(_, bufnr)
		-- Java-specific keymaps
		local opts = { buffer = bufnr }
		vim.keymap.set("n", "<leader>jo", function()
			vim.lsp.buf.execute_command({
				command = "java.edit.organizeImports",
				arguments = { vim.uri_from_bufnr(bufnr) },
			})
		end, vim.tbl_extend("force", opts, { desc = "Organize imports" }))
	end,
})

return {
	name = "java",
	lsp = "jdtls",
	enabled = true,
}
