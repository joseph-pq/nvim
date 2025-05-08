-- Initially taken from https://github.com/Rishabh672003/Neovim/blob/main/lua%2Frj%2Flsp.lua
-- local lsp_zero = require('lsp-zero')
-- local lspconfig = require('lspconfig')

-- Setup mason
require('mason').setup()
-- require('mason-lspconfig').setup({
--   ensure_installed = { 'rust_analyzer', 'pyright', 'ruff', 'texlab', 'ts_ls', 'lua_ls' },
-- })

-- Load snippets
-- require('luasnip.loaders.from_vscode').lazy_load()

-- Completion
-- local cmp = require('cmp')
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = cmp.mapping.preset.insert({
--   ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--   ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--   ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--   ['<C-Space>'] = cmp.mapping.complete(),
-- })
-- cmp.setup({
--   sources = {
--     { name = 'path' },
--     { name = 'nvim_lsp' },
--     { name = 'nvim_lua' },
--     { name = 'luasnip', keyword_length = 2 },
--     { name = 'buffer',  keyword_length = 3 },
--   },
--   -- formatting = lsp_zero.cmp_format({ details = false }),
--   mapping = cmp_mappings,
-- })

-- -- Capabilities
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- -- capabilities.textDocument.publishDiagnostics = {
-- --   tagSupport = { valueSet = { 2 } }
-- -- }

-- -- on_attach function
-- local function on_attach(client, bufnr)
--   local opts = { buffer = bufnr, remap = false }
--   local keymap = vim.keymap.set

--   keymap("n", "gd", vim.lsp.buf.definition, opts)
--   keymap("n", "K", vim.lsp.buf.hover, opts)
--   keymap("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
--   keymap("n", "<leader>vd", vim.diagnostic.open_float, opts)
--   keymap("n", "]d", vim.diagnostic.goto_next, opts)
--   keymap("n", "[d", vim.diagnostic.goto_prev, opts)
--   keymap("n", "<leader>vca", vim.lsp.buf.code_action, opts)
--   keymap("n", "<leader>vrr", vim.lsp.buf.references, opts)
--   keymap("n", "<leader>vrn", vim.lsp.buf.rename, opts)
--   keymap("i", "<C-h>", vim.lsp.buf.signature_help, opts)
-- end

-- lsp_zero.on_attach(on_attach)

-- -- Server configurations
-- local servers = {
--   pyright = {
--     settings = {
--       pyright = { disableOrganizeImports = true },
--       python = { analysis = {} },
--     }
--   },
--   bashls = {
--     filetypes = { "sh", "bash", "zsh" },
--   },
--   ts_ls = {
--     init_options = {
--       preferences = {
--         disableSuggestions = true,
--       },
--     },
--   },
--   ruff = {},
--   lua_ls = {
--     settings = {
--       Lua = {
--         runtime = {
--           version = "LuaJIT",
--           special = { reload = "require" },
--         },
--         workspace = {
--           library = {
--             vim.fn.expand("$VIMRUNTIME/lua"),
--             vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
--             vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
--           },
--         },
--       },
--     }
--   },
-- }

-- -- Setup LSP servers
-- for name, opts in pairs(servers) do
--   opts.capabilities = capabilities
--   opts.on_attach = on_attach
--   lspconfig[name].setup(opts)
-- end

local config = {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    style = "minimal",
    border = "single",
    source = "always",
    header = "",
    prefix = "",
    suffix = "",
  },
}
vim.diagnostic.config(config)

local icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = "󰊕 ",
  Interface = " ",
  Keyword = " ",
  Method = "ƒ ",
  Module = "󰏗 ",
  Property = " ",
  Snippet = " ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
  completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end


vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      -- vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
    end
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    -- -- nightly has inbuilt completions, this can replace all completion plugins
    -- if client:supports_method("textDocument/completion", bufnr) then
    --   -- Enable auto-completion
    --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    -- end

    --- Disable semantic tokens
    ---@diagnostic disable-next-line need-check-nil
    client.server_capabilities.semanticTokensProvider = nil

    -- All the keymaps
    -- stylua: ignore start
    local keymap = vim.keymap.set
    local lsp = vim.lsp
    local opts = { silent = true }
    local function opt(desc, others)
      return vim.tbl_extend("force", opts, { desc = desc }, others or {})
    end
    keymap("n", "gd", lsp.buf.definition, opt("Go to definition"))
    keymap("n", "gD", function()
      local ok, diag = pcall(require, "rj.extras.definition")
      if ok then
        diag.get_def()
      end
    end, opt("Get the definition in a float"))
    -- keymap("n", "gi", function() lsp.buf.implementation({ border = "single" })  end, opt("Go to implementation"))
    -- keymap("n", "gr", lsp.buf.references, opt("Show References"))
    keymap("n", "grl", vim.diagnostic.open_float, opt("Open diagnostic in float"))
    keymap("n", "<C-k>", lsp.buf.signature_help, opts)
    -- disable the default binding first before using a custom one
    pcall(vim.keymap.del, "n", "K", { buffer = ev.buf })
    keymap("n", "K", function() lsp.buf.hover({ border = "single", max_height = 30, max_width = 120 }) end,
      opt("Toggle hover"))
    keymap("n", "<Leader>lF", vim.cmd.FormatToggle, opt("Toggle AutoFormat"))
    keymap("n", "<Leader>lI", vim.cmd.Mason, opt("Mason"))
    keymap("n", "<Leader>lS", lsp.buf.workspace_symbol, opt("Workspace Symbols"))
    keymap("n", "<Leader>la", lsp.buf.code_action, opt("Code Action"))
    keymap("n", "<Leader>lh", function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({})) end,
      opt("Toggle Inlayhints"))
    keymap("n", "<Leader>li", vim.cmd.LspInfo, opt("LspInfo"))
    keymap("n", "<Leader>ll", lsp.codelens.run, opt("Run CodeLens"))
    keymap("n", "<Leader>lr", lsp.buf.rename, opt("Rename"))
    keymap("n", "<Leader>ls", lsp.buf.document_symbol, opt("Doument Symbols"))

    -- diagnostic mappings
    keymap("n", "<Leader>dD", function()
      local ok, diag = pcall(require, "rj.extras.workspace-diagnostic")
      if ok then
        for _, cur_client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          diag.populate_workspace_diagnostics(cur_client, 0)
        end
        vim.notify("INFO: Diagnostic populated")
      end
    end, opt("Popluate diagnostic for the whole workspace"))
    keymap("n", "<Leader>dn", function() vim.diagnostic.jump({ count = 1, float = true }) end, opt("Next Diagnostic"))
    keymap("n", "<Leader>dp", function() vim.diagnostic.jump({ count = -1, float = true }) end, opt("Prev Diagnostic"))
    keymap("n", "<Leader>dq", vim.diagnostic.setloclist, opt("Set LocList"))
    keymap("n", "<Leader>dv", function()
      vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
    end, opt("Toggle diagnostic virtual_lines"))
    -- stylua: ignore end
  end,
})


-- Setup LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}
-- Forced to utf-16 because some servers by default uses utf-8 and others
-- do not support utf-32. Thus, the common denominator is utf-16.
capabilities.general.positionEncodings = { "utf-16" }
capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    local ok, diag = pcall(require, "rj.extras.workspace-diagnostic")
    if ok then
      diag.populate_workspace_diagnostics(client, bufnr)
    end
  end,
})


vim.lsp.config["lua_ls"] = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".git", vim.uv.cwd() },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        special = { reload = "require" },
      },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
          vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
        },
      },
    },
  },
}

vim.lsp.config["ruff_lsp"] = {
  cmd = { "ruff", "server" },
  root_markers = { ".git", "setup.py", "setup.cfg", "pyproject.toml" },
  filetypes = { "python" },
}
-- Ruff: disable hover to let Pyright handle it
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})

vim.lsp.config["pyright"] = {
  cmd = { "pyright-langserver", "--stdio" },
  root_markers = { ".git", "setup.py", "setup.cfg", "pyproject.toml" },
  filetypes = { "python" },
  settings = {
    pyright = { disableOrganizeImports = true },
    python = { analysis = {} },
  },
}

-- Enable features based on client capabilities
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client ~= nil and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

-- Add noselect to completeopt, otherwise autocompletion is annoying
vim.cmd("set completeopt+=noselect")

vim.lsp.enable({ 'lua_ls' })
vim.lsp.enable({ 'pyright' })
vim.lsp.enable({ 'ruff_lsp' })
