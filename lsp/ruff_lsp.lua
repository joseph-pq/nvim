-- Ruff: disable hover to let Pyright handle it
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})

---@type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  root_markers = { ".git", "setup.py", "setup.cfg", "pyproject.toml" },
  filetypes = { "python" },
  init_options = {
    settings = {
      logFile = vim.fn.stdpath("state") .. "/ruff_lsp.log",
    },
  },
}
