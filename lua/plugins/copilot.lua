local avante_disabled_tools = {
  "list_files", -- Built-in file operations
  "search_files",
  "read_file",
  "create_file",
  "rename_file",
  "delete_file",
  "create_dir",
  "rename_dir",
  "delete_dir",
  "bash", -- Built-in terminal access
}

local avante_rag_service = {
  enabled = os.getenv("AVANTE_RAG_HOST_MOUNT") ~= nil and os.getenv("AVANTE_RAG_HOST_MOUNT") ~= "", -- Enables the RAG service only if the environment variable exists and is not empty
  host_mount = os.getenv("AVANTE_RAG_HOST_MOUNT"), -- Host mount path for the rag service
  provider = "ollama", -- The provider to use for RAG service (e.g. openai or ollama)
  llm_model = os.getenv("AVANTE_OLLAMA_MODEL"), -- The LLM model to use for RAG service
  embed_model = "nomic-embed-text", -- The embedding model to use for RAG service
  endpoint = os.getenv("AVANTE_OLLAMA_ENDPOINT"), -- The API endpoint for RAG service
}

local codecompanion_history = {
  enabled = true,
  opts = {
    -- Keymap to open history from chat buffer (default: gh)
    keymap = "gh",
    -- Keymap to save the current chat manually (when auto_save is disabled)
    save_chat_keymap = "sc",
    -- Save all chats by default (disable to save only manually using 'sc')
    auto_save = true,
    -- Number of days after which chats are automatically deleted (0 to disable)
    expiration_days = 0,
    -- Picker interface (auto resolved to a valid picker)
    picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default")
    ---Optional filter function to control which chats are shown when browsing
    chat_filter = nil, -- function(chat_data) return boolean end
    -- Customize picker keymaps (optional)
    picker_keymaps = {
      rename = { n = "r", i = "<M-r>" },
      delete = { n = "d", i = "<M-d>" },
      duplicate = { n = "<C-y>", i = "<C-y>" },
    },
    ---Automatically generate titles for new chats
    auto_generate_title = true,
    title_generation_opts = {
      ---Adapter for generating titles (defaults to current chat adapter)
      adapter = nil, -- "copilot"
      ---Model for generating titles (defaults to current chat model)
      model = nil, -- "gpt-4o"
      ---Number of user prompts after which to refresh the title (0 to disable)
      refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
      ---Maximum number of times to refresh the title (default: 3)
      max_refreshes = 3,
      format_title = function(original_title)
        -- this can be a custom function that applies some custom
        -- formatting to the title.
        return original_title
      end,
    },
    ---On exiting and entering neovim, loads the last chat on opening chat
    continue_last_chat = false,
    ---When chat is cleared with `gx` delete the chat from history
    delete_on_clearing_chat = false,
    ---Directory path to save the chats
    dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
    ---Enable detailed logging for history extension
    enable_logging = false,

    -- Summary system
    summary = {
      -- Keymap to generate summary for current chat (default: "gcs")
      create_summary_keymap = "gcs",
      -- Keymap to browse summaries (default: "gbs")
      browse_summaries_keymap = "gbs",

      generation_opts = {
        adapter = nil, -- defaults to current chat adapter
        model = nil, -- defaults to current chat model
        context_size = 90000, -- max tokens that the model supports
        include_references = true, -- include slash command content
        include_tool_outputs = true, -- include tool execution results
        system_prompt = nil, -- custom system prompt (string or function)
        format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
      },
    },

    -- Memory system (requires VectorCode CLI)
    memory = {
      -- Automatically index summaries when they are generated
      auto_create_memories_on_summary_generation = true,
      -- Path to the VectorCode executable
      vectorcode_exe = "vectorcode",
      -- Tool configuration
      tool_opts = {
        -- Default number of memories to retrieve
        default_num = 10,
      },
      -- Enable notifications for indexing progress
      notify = true,
      -- Index all existing memories on startup
      -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
      index_on_startup = false,
    },
  },
}

local avante_providers = {
  -- avante_commands = {
  --   name = "avante_commands",
  --   module = "blink.compat.source",
  --   score_offset = 90, -- show at a higher priority than lsp
  --   opts = {},
  -- },
  -- avante_files = {
  --   name = "avante_files",
  --   module = "blink.compat.source",
  --   score_offset = 100, -- show at a higher priority than lsp
  --   opts = {},
  -- },
  -- avante_mentions = {
  --   name = "avante_mentions",
  --   module = "blink.compat.source",
  --   score_offset = 1000, -- show at a higher priority than lsp
  --   opts = {},
  -- },
  -- avante_shortcuts = {
  --   name = "avante_shortcuts",
  --   module = "blink.compat.source",
  --   score_offset = 1000, -- show at a higher priority than lsp
  --   opts = {},
  -- },

  ["gemini-3.5"] = {
    __inherited_from = "gemini",
    model = "gemini-3.5-flash",
  },
  bedrock = {
    model = os.getenv("AVANTE_BEDROCK_MODEL") or "anthropic.claude-3-5-sonnet-20241022-v2:0",
  },
  ollama = {
    endpoint = os.getenv("AVANTE_OLLAMA_ENDPOINT") or "http://localhost:11434",
    model = os.getenv("AVANTE_OLLAMA_MODEL") or "qwen2.5-coder:3b",
  },
  ["copilot:claude-3.5"] = {
    __inherited_from = "copilot",
    model = "claude-3.5-sonnet",
    extra_request_body = {
      max_tokens = 65536,
    },
  },
  ["copilot:claude-3.7"] = {
    __inherited_from = "copilot",
    model = "claude-3.7-sonnet",
    extra_request_body = {
      max_tokens = 65536,
    },
  },
  ["copilot:claude-3.7-thought"] = {
    __inherited_from = "copilot",
    model = "claude-3.7-sonnet-thought",
    extra_request_body = {
      max_tokens = 65536,
    },
  },
  ["copilot:o4-mini"] = {
    __inherited_from = "copilot",
    model = "o4-mini",
    extra_request_body = {
      max_tokens = 100000,
    },
  },
  ["copilot:gpt-4.1"] = {
    __inherited_from = "copilot",
    model = "gpt-4.1",
    extra_request_body = {
      max_tokens = 32768,
    },
  },
  ["copilot:gemini-2.0"] = {
    __inherited_from = "copilot",
    model = "gemini-2.0-flash-001",
    extra_request_body = {
      max_tokens = 8192,
    },
  },
  ["copilot:gemini-2.5"] = {
    __inherited_from = "copilot",
    model = "gemini-2.5-pro-preview-05-06",
    extra_request_body = {
      max_tokens = 65536,
    },
  },
  ["copilot-gaa"] = {
    __inherited_from = "copilot",
    model = "gpt-5-mini",
  },
  -- gemini_pro = {
  --   __inherited_from = "gemini",
  --   model = "gemini-2.5-pro-preview-03-25",
  -- },
  -- gemini_litellm = {
  --   __inherited_from = "gemini",
  --   endpoint = (os.getenv("LITELLM_HOST") or "") .. "/gemini/v1beta/models",
  --   api_key_name = "LITELLM_KEY",
  -- },
  -- ollama_litellm = {
  --   __inherited_from = "openai",
  --   endpoint = os.getenv("LITELLM_HOST"),
  --   model = "qwen2-5",
  --   max_completion_tokens = nil,
  --   api_key_name = "LITELLM_KEY",
  -- },
  -- groq = { -- define groq provider
  --   __inherited_from = "openai",
  --   api_key_name = "GROQ_API_KEY",
  --   endpoint = "https://api.groq.com/openai/v1/",
  --   model = "llama-3.3-70b-versatile",
  --   extra_request_body = {
  --     max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
  --   },
  -- },
}

local tmux_tool = {
  name = "execute_tmux_command", -- Unique name for the new tool
  description = "Execute a bash command in and retrieve results",
  command = "tmux send-keys -t $TMUX_WINDOW", -- Base command to send keys to tmux
  param = { -- Input parameters
    type = "table",
    fields = {
      {
        name = "command",
        description = "Bash command to execute",
        type = "string",
        optional = false,
      },
    },
  },
  returns = { -- Expected return values
    {
      name = "result",
      description = "Result of the command execution",
      type = "string",
    },
    {
      name = "error",
      description = "0 if successful. If the value is between 1 and 255, it indicates a bash error. A value of 256 means the command did not finish. Otherwise, it is the error message.",
      type = "string",
      optional = true,
    },
  },
  func = function(params, on_log, on_complete) -- Custom function to execute
    local tmux_window = os.getenv("AVANTE_TMUX_WINDOW")
    if not tmux_window then
      return nil, "AVANTE_TMUX_WINDOW environment variable is not set"
    end
    local command = params.command
    local full_command = string.format(
      "tmux send-keys -t %s 'rm -f /tmp/avante-status; %s | tee /tmp/avante-out; echo $? > /tmp/avante-status' C-m",
      tmux_window,
      command
    )
    local result = vim.fn.system(full_command)
    if vim.v.shell_error ~= 0 then
      return nil, result
    end

    -- Wait for the command to execute, checking every 500ms for up to 5 seconds
    local timeout = 5000
    local interval = 500
    local elapsed = 0
    while elapsed < timeout do
      vim.wait(interval)
      elapsed = elapsed + interval
      if vim.fn.filereadable("/tmp/avante-status") == 1 then
        break
      end
    end

    -- Retrieve the result from the /tmp/out file
    local output = vim.fn.readfile("/tmp/avante-out")
    if vim.v.shell_error ~= 0 then
      return nil, "Failed to read output file"
    end
    -- how to print a table
    -- Check if the command finished successfully
    local status = vim.fn.readfile("/tmp/avante-status")
    if vim.v.shell_error ~= 0 then
      return table.concat(output, "\n"), -1
    end
    -- Join the output lines into a single string
    return table.concat(output, "\n")
  end,
}

local avante_system_prompt = function()
  local hub = require("mcphub").get_hub_instance()
  -- check nil
  if not hub then
    return nil, "MCPHub instance is not available"
  end
  return hub:get_active_servers_prompt() or ""
end

local avante_custom_tools = function()
  return { require("mcphub.extensions.avante").mcp_tool() }
end

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<tab>",
          },
        },
        filetypes = {
          markdown = true,
          gitcommit = true,
          tex = false,
        },
      })
    end,
  },
  -- {
  -- 	'github/copilot.vim',
  -- 	event = "VeryLazy",
  -- },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "ravitemer/mcphub.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- uncomment the following line to load hub lazily
    --cmd = "MCPHub",  -- lazy load
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    opts = {
      auto_approve = true,
      extensions = {
        avante = {
          make_slash_commands = true,
        },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    keys = {
      { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion Chat" },
    },
    dependencies = {
      "ravitemer/codecompanion-history.nvim",
    },
    opts = {
      interactions = {
        chat = {
          adapter = {
            name = "gemini",
            model = "gemini-3.5-flash",
          },
        },
      },
      rules = {
        default = {
          description = "Collection of common files for all projects",
          files = {
            ".clinerules",
            ".cursorrules",
            ".goosehints",
            ".rules",
            ".windsurfrules",
            ".github/copilot-instructions.md",
            "AGENT.md",
            "AGENTS.md",
            { path = "CLAUDE.md", parser = "claude" },
            { path = "CLAUDE.local.md", parser = "claude" },
            { path = "~/.claude/CLAUDE.md", parser = "claude" },
          },
          is_preset = true,
        },
        opts = {
          chat = {
            autoload = "default", -- The rule groups to load
            enabled = true,
          },
        },
      },
      extensions = {
        history = codecompanion_history,
      },
    },
  },
  {
    "yetone/avante.nvim",
    dev = os.getenv("NVIM_AVANTE_DEV") == "true",
    enabled = false,
    -- enable = false,
    event = "VeryLazy",
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    key = {
      {
        "<leader>an",
        function()
          require("avante.api").ask({ ask = false, new_chat = true })
        end,
        desc = "Avante: New Chat",
      },
    },
    ---@type avante.Config
    opts = {
      instructions_file = "avante.md",
      debug = os.getenv("NVIM_AVANTE_DEV") == "true",
      -- provider = os.getenv("AVANTE_PROVIDER") or "copilot",
      provider = "copilot-gaa",
      auto_suggestions_provider = nil,
      mode = "agentic",
      providers = avante_providers, -- Providers configuration
      rag_service = avante_rag_service, -- RAG service configuration
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      -- "hrsh7th/nvim-cmp",           -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "echasnovski/mini.icons",
      "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
  },
  {
    -- support for image pasting
    "HakonHarnes/img-clip.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      -- recommended settings
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
        use_absolute_path = false,
      },
      filetypes = {
        markdown = {
          template = '<center><img src="$FILE_PATH" alt="$CURSOR"/></center>',
        },
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
    keys = {
      -- suggested keymap
      { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
}
