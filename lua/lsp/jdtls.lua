local jdtls = require("jdtls")

local M = {}

M.start = function()
	local root_dir = require("jdtls.setup").find_root({ ".git", "pom.xml", "build.gradle", "settings.gradle" })
	if root_dir == nil then
		return
	end

	local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
	local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/workspace/" .. project_name

	local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

	local on_attach = require("lsp.on_attach").setup

	local config = {
		cmd = {
			"java",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xms1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",
			"-jar",
			vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
			"-configuration",
			jdtls_path .. "/config_mac",
			"-data",
			workspace_dir,
		},
		root_dir = root_dir,
		settings = {
			java = {
				eclipse = {
					downloadSources = true,
				},
				configuration = {
					updateBuildConfiguration = "automatic",
				},
				maven = {
					downloadSources = true,
					updateSnapshots = true,
				},
				implementationsCodeLens = {
					enabled = true,
				},
				referencesCodeLens = {
					enabled = true,
				},
				references = {
					includeDecompiledSources = true,
				},
				format = {
					enabled = true,
				},
			},
		},
		on_attach = on_attach,
		init_options = {
			bundles = {},
		},
	}

	jdtls.start_or_attach(config)
end

return M
