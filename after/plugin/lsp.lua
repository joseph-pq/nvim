vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gd", require("snacks").picker.lsp_definitions, "[G]oto [D]efinition")
    map("grr", require("snacks").picker.lsp_references, "[G]oto [R]eferences")
    --    keymap("n", "grl", vim.diagnostic.open_float, opt("Open diagnostic in float"))
    map("grl", vim.diagnostic.open_float, "[G]oto Diagnostic")
    map("gI", require("snacks").picker.lsp_implementations, "[G]oto [I]mplementation")
    -- map("<leader>D", require("snacks").picker.lsp_type_definitions, "Type [D]efinition")
    map("<leader>ds", require("snacks").picker.lsp_symbols, "[D]ocument [S]ymbols")
    map("<leader>ws", require("snacks").picker.lsp_workspace_symbols, "[W]orkspace [S]ymbols")
    map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("gra", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("K", function()
      vim.lsp.buf.hover({ border = "rounded" })
    end, "Hover Documentation")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    -- will be done with conform
    -- map("<leader>f", vim.lsp.buf.format, "[F]ormat the document")

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
        end,
      })
    end
  end,
})
-- Initially taken from https://github.com/Rishabh672003/Neovim/blob/main/lua%2Frj%2Flsp.lua
--vim.diagnostic.config(
--  {
--    signs = {
--      text = {
--        [vim.diagnostic.severity.ERROR] = "",
--        [vim.diagnostic.severity.WARN] = "",
--        [vim.diagnostic.severity.HINT] = "",
--        [vim.diagnostic.severity.INFO] = "",
--      },
--    },
--    update_in_insert = true,
--    underline = true,
--    severity_sort = true,
--    float = {
--      style = "minimal",
--      border = "single",
--      -- source = "always",
--      header = "",
--      prefix = "",
--      suffix = "",
--    },
--  }
--)

--local icons = {
--  Class = " ",
--  Color = " ",
--  Constant = " ",
--  Constructor = " ",
--  Enum = " ",
--  EnumMember = " ",
--  Event = " ",
--  Field = " ",
--  File = " ",
--  Folder = " ",
--  Function = "󰊕 ",
--  Interface = " ",
--  Keyword = " ",
--  Method = "ƒ ",
--  Module = "󰏗 ",
--  Property = " ",
--  Snippet = " ",
--  Struct = " ",
--  Text = " ",
--  Unit = " ",
--  Value = " ",
--  Variable = " ",
--}

--local completion_kinds = vim.lsp.protocol.CompletionItemKind
--for i, kind in ipairs(completion_kinds) do
--  completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
--end

--vim.api.nvim_create_autocmd("LspAttach", {
--  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
--  callback = function(event)
--    local bufnr = event.buf
--    local client = vim.lsp.get_client_by_id(event.data.client_id)
--    if not client then
--      return
--    end
--    ---@diagnostic disable-next-line need-check-nil
--    if client.server_capabilities.completionProvider then
--      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
--      -- vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
--    end
--    ---@diagnostic disable-next-line need-check-nil
--    if client.server_capabilities.definitionProvider then
--      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
--    end

--    -- -- nightly has inbuilt completions, this can replace all completion plugins
--    -- if client:supports_method("textDocument/completion", bufnr) then
--    --   -- Enable auto-completion
--    --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
--    -- end

--    --- Disable semantic tokens
--    ---@diagnostic disable-next-line need-check-nil
--    client.server_capabilities.semanticTokensProvider = nil

--    -- All the keymaps
--    -- stylua: ignore start
--    local keymap = vim.keymap.set
--    local lsp = vim.lsp
--    local opts = { silent = true }
--    local function opt(desc, others)
--      return vim.tbl_extend("force", opts, { desc = desc }, others or {})
--    end
--    keymap("n", "gd", lsp.buf.definition, opt("Go to definition"))
--    keymap("n", "gD", function()
--      local ok, diag = pcall(require, "rj.extras.definition")
--      if ok then
--        diag.get_def()
--      end
--    end, opt("Get the definition in a float"))
--    -- keymap("n", "gi", function() lsp.buf.implementation({ border = "single" })  end, opt("Go to implementation"))
--    -- keymap("n", "gr", lsp.buf.references, opt("Show References"))
--    keymap("n", "grl", vim.diagnostic.open_float, opt("Open diagnostic in float"))
--    keymap("n", "<C-k>", lsp.buf.signature_help, opts)
--    -- disable the default binding first before using a custom one
--    pcall(vim.keymap.del, "n", "K", { buffer = event.buf })
--    keymap("n", "K", function() lsp.buf.hover({ border = "single", max_height = 30, max_width = 120 }) end,
--      opt("Toggle hover"))
--    keymap("n", "<Leader>lF", vim.cmd.FormatToggle, opt("Toggle AutoFormat"))
--    keymap("n", "<Leader>lI", vim.cmd.Mason, opt("Mason"))
--    keymap("n", "<Leader>lS", lsp.buf.workspace_symbol, opt("Workspace Symbols"))
--    keymap("n", "<Leader>la", lsp.buf.code_action, opt("Code Action"))
--    keymap("n", "<Leader>lh", function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({})) end,
--      opt("Toggle Inlayhints"))
--    keymap("n", "<Leader>li", vim.cmd.LspInfo, opt("LspInfo"))
--    keymap("n", "<Leader>ll", lsp.codelens.run, opt("Run CodeLens"))
--    keymap("n", "<Leader>lr", lsp.buf.rename, opt("Rename"))
--    keymap("n", "<Leader>ls", lsp.buf.document_symbol, opt("Doument Symbols"))

--    -- diagnostic mappings
--    keymap("n", "<Leader>dD", function()
--      local ok, diag = pcall(require, "rj.extras.workspace-diagnostic")
--      if ok then
--        for _, cur_client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
--          diag.populate_workspace_diagnostics(cur_client, 0)
--        end
--        vim.notify("INFO: Diagnostic populated")
--      end
--    end, opt("Popluate diagnostic for the whole workspace"))
--    keymap("n", "<Leader>dn", function() vim.diagnostic.jump({ count = 1, float = true }) end, opt("Next Diagnostic"))
--    keymap("n", "<Leader>dp", function() vim.diagnostic.jump({ count = -1, float = true }) end, opt("Prev Diagnostic"))
--    keymap("n", "<Leader>dq", vim.diagnostic.setloclist, opt("Set LocList"))
--    keymap("n", "<Leader>dv", function()
--      vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
--    end, opt("Toggle diagnostic virtual_lines"))
--    -- stylua: ignore end
--  end,
--})

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- -- Setup LSP capabilities
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = true,
--   lineFoldingOnly = true,
-- }
-- -- Forced to utf-16 because some servers by default uses utf-8 and others
-- -- do not support utf-32. Thus, the common denominator is utf-16.
-- capabilities.general.positionEncodings = { "utf-16" }
-- capabilities.textDocument.semanticTokens.multilineTokenSupport = true
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- vim.lsp.config("*", {
--   capabilities = capabilities,
--   on_attach = function(client, bufnr)
--     local ok, diag = pcall(require, "rj.extras.workspace-diagnostic")
--     if ok then
--       diag.populate_workspace_diagnostics(client, bufnr)
--     end
--   end,
-- })

-- -- Enable features based on client capabilities
-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client ~= nil and client:supports_method('textDocument/completion') then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })

-- Add noselect to completeopt, otherwise autocompletion is annoying
-- vim.cmd("set completeopt+=noselect")

vim.lsp.enable({ "lua_ls" })
vim.lsp.enable({ "pyright" })
vim.lsp.enable({ "ruff_lsp" })
