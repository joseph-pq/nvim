local ts = require("nvim-treesitter")

ts.setup({})

ts.install({
  "gitcommit",
  "vimdoc",
  "vim",
  "query",
  "javascript",
  "python",
  "typescript",
  "c",
  "lua",
  "rust",
  "latex",
  "markdown",
  "http",
  "html",
  "css",
  -- "norg",
  "scss",
  "svelte",
  "tsx",
  "typst",
  "vue",
})
