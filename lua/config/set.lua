vim.opt.guicursor = ""

-- numbers
vim.opt.nu = true -- enable number
vim.opt.relativenumber = true -- relative number

-- tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true -- Highlight the token while typing a search command

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
-- vim.opt.textwidth = 80
-- vim.opt.wrap = true

vim.g.mapleader = "\\"

vim.g.python3_host_prog = os.getenv("HOME") .. "/.config/nvim/.venv/bin/python"

vim.opt.conceallevel = 1
