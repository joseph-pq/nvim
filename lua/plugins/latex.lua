return {
	{
		'lervag/vimtex',
		lazy = false,
		init = function ()
			vim.g.vimtex_compiler_latexmk = {
			  out_dir = 'build',
			}
			-- vim.g.vimtex_compiler_method = "xelatex"
		end
	},
}
