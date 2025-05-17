-- Doc of options:
-- - https://github.com/microsoft/pyright/blob/main/docs/settings.md
-- - https://microsoft.github.io/pyright/#/settings

---@type vim.lsp.Config
return {
	cmd = { "pyright-langserver", "--stdio" },
	root_markers = { ".git", "setup.py", "setup.cfg", "pyproject.toml" },
	filetypes = { "python" },
	settings = {
		pyright = {
			disableOrganizeImports = true,
			autoSearchPaths = true,
			autoImportCompletions = true,
			useLibraryCodeForTypes = true,
		},
		python = {
			analysis = {
				-- ignore = { "*" },
			},
		},
	},
}
