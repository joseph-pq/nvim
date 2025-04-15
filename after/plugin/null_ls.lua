local null_ls = require('null-ls')
null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.mypy.with({
			extra_args = {'--python-executable', 'python'},
			-- extra_args = (function()
			-- 	local venv_python = ".venv/bin/python"
			-- 	if vim.fn.filereadable(venv_python) == 1 then
			-- 		return { "--python-executable", venv_python }
			-- 	elseif vim.fn.executable("python") == 1 then
			-- 		return { "--python-executable", "python" }
			-- 	else
			-- 		return { "--python-executable", "python3" }
			-- 	end
			-- end)(),

			command = vim.fn.stdpath("data") .. "/mason/bin/mypy",
		}),
		-- null_ls.builtins.diagnostics.proselint,
		-- null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.prettier,
	}
})
