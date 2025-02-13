local null_ls = require('null-ls')
null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.mypy.with({
			extra_args = { '--python-executable', 'python' },
		}),
		null_ls.builtins.diagnostics.proselint,
		null_ls.builtins.formatting.isort,
	}
})
