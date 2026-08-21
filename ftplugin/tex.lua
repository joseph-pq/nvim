-- configure expired from: https://stackoverflow.com/a/50415982
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.linebreak = true -- breaks by word rather than character
vim.opt.wrap = true
-- set max width to 80
vim.opt.textwidth = 0
-- vim.opt.columns=80
vim.opt.conceallevel = 0 -- Disable special rendering of certain characters

vim.keymap.set("n", "<leader>tmh", function()
  Snacks.picker("vimtex_toc", { layers = "c" })
end, { buffer = true, desc = "LaTeX document headings" })

vim.opt.spell = true
vim.opt.spelllang = { 'en' }
