-- Copied from https://github.com/jellydn/lazy-nvim-ide/blob/5238b765d423a16098c23d7b0a581695ead54c93/lua/plugins/extras/copilot-chat-v2.lua
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
					}
				},
				filetypes = {
					gitcommit = true,
				}
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
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
		},
		-- uncomment the following line to load hub lazily
		--cmd = "MCPHub",  -- lazy load
		build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
		-- uncomment this if you don't want mcp-hub to be available globally or can't use -g
		-- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
		config = function()
			require("mcphub").setup({
				auto_approve = true,
				extensions = {
					avante = {
						make_slash_commands = true,
					}
				}
			})
		end,
	},
	{
		"yetone/avante.nvim",
		dev = os.getenv("NVIM_AVANTE_DEV") == "true",
		event = "VeryLazy",
		version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
		config = function()
			-- add keymap to <leader>an to run AvanteChatNew command
			vim.keymap.set("n", "<leader>an", function()
				require("avante.api").ask({ ask = false, new_chat = true })
			end, { desc = "Avante: New Chat" })
			require("avante").setup({
				debug = os.getenv("NVIM_AVANTE_DEV") == "true",
				provider = os.getenv("AVANTE_PROVIDER") or "copilot",
				auto_suggestions_provider = nil,
				cursor_applying_provider = 'gemini_pro',
				gemini = {
					model = "gemini-2.5-flash-preview-04-17",
				},
				behaviour = {
					enable_cursor_planning_mode = true,
				},
				bedrock = {
					model = os.getenv("AVANTE_BEDROCK_MODEL") or "anthropic.claude-3-5-sonnet-20241022-v2:0",
				},
				ollama = {
					endpoint = os.getenv("AVANTE_OLLAMA_ENDPOINT") or "http://localhost:11434",
					model = os.getenv("AVANTE_OLLAMA_MODEL") or "qwen2.5-coder:3b",
				},
				vendors = {
					["copilot:claude-3.5"] = {
						__inherited_from = "copilot",
						model = "claude-3.5-sonnet",
						max_tokens = 65536,
					},
					["copilot:claude-3.7"] = {
						__inherited_from = "copilot",
						model = "claude-3.7-sonnet",
						max_tokens = 65536,
					},
					["copilot:claude-3.7-thought"] = {
						__inherited_from = "copilot",
						model = "claude-3.7-sonnet-thought",
						max_tokens = 65536,
					},
					["copilot:o4-mini"] = {
						__inherited_from = "copilot",
						model = "o4-mini",
						max_tokens = 100000,
					},
					["copilot:gpt-4.1"] = {
						__inherited_from = "copilot",
						model = "gpt-4.1",
						max_tokens = 32768,
					},
					["copilot:gemini-2.0"] = {
						__inherited_from = "copilot",
						model = "gemini-2.0-flash-001",
						max_tokens = 8192,
					},
					["copilot:gemini-2.5"] = {
						__inherited_from = "copilot",
						model = "gemini-2.5-pro-preview-03-25",
						max_tokens = 65536,
					},
					gemini_pro = {
						__inherited_from = 'gemini',
						model = "gemini-2.5-pro-preview-03-25"
					},
					gemini_litellm = {
						endpoint = (os.getenv("LITELLM_HOST") or "") .. "/gemini/v1beta/models",
						api_key_name = "LITELLM_KEY",
					},
					ollama_litellm = {
						__inherited_from = 'openai',
						endpoint = os.getenv("LITELLM_HOST"),
						model = "qwen2-5",
						max_completion_tokens = nil,
						api_key_name = "LITELLM_KEY",
					},
					groq = { -- define groq provider
						__inherited_from = 'openai',
						api_key_name = "GROQ_API_KEY",
						endpoint = 'https://api.groq.com/openai/v1/',
						model = 'llama-3.3-70b-versatile',
						max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
					},
				},
				rag_service = {
					enabled = os.getenv("AVANTE_RAG_HOST_MOUNT") ~= nil and os.getenv("AVANTE_RAG_HOST_MOUNT") ~= "", -- Enables the RAG service only if the environment variable exists and is not empty
					host_mount = os.getenv("AVANTE_RAG_HOST_MOUNT"), -- Host mount path for the rag service
					provider = "ollama",                            -- The provider to use for RAG service (e.g. openai or ollama)
					llm_model = os.getenv("AVANTE_OLLAMA_MODEL"),   -- The LLM model to use for RAG service
					embed_model = "nomic-embed-text",               -- The embedding model to use for RAG service
					endpoint = os.getenv("AVANTE_OLLAMA_ENDPOINT"), -- The API endpoint for RAG service
				},
				-- disabled_tools = {
				-- 	"bash",
				-- },
				disabled_tools = {
					"list_files",
					"search_files",
					"read_file",
					"create_file",
					"rename_file",
					"delete_file",
					"create_dir",
					"rename_dir",
					"delete_dir",
					"bash",
				},
				system_prompt = function()
					local hub = require("mcphub").get_hub_instance()
					-- check nil
					if not hub then
						return nil, "MCPHub instance is not available"
					end
					return hub:get_active_servers_prompt()
				end,
				custom_tools = {
					require("mcphub.extensions.avante").mcp_tool(),
					-- {
					-- 	name = "execute_tmux_command",        -- Unique name for the new tool
					-- 	description = "Execute a bash command in and retrieve results",
					-- 	command = "tmux send-keys -t $TMUX_WINDOW", -- Base command to send keys to tmux
					-- 	param = {                             -- Input parameters
					-- 		type = "table",
					-- 		fields = {
					-- 			{
					-- 				name = "command",
					-- 				description = "Bash command to execute",
					-- 				type = "string",
					-- 				optional = false,
					-- 			},
					-- 		},
					-- 	},
					-- 	returns = { -- Expected return values
					-- 		{
					-- 			name = "result",
					-- 			description = "Result of the command execution",
					-- 			type = "string",
					-- 		},
					-- 		{
					-- 			name = "error",
					-- 			description =
					-- 			"0 if successful. If the value is between 1 and 255, it indicates a bash error. A value of 256 means the command did not finish. Otherwise, it is the error message.",
					-- 			type = "string",
					-- 			optional = true,
					-- 		},
					-- 	},
					-- 	func = function(params, on_log, on_complete) -- Custom function to execute
					-- 		local tmux_window = os.getenv("AVANTE_TMUX_WINDOW")
					-- 		if not tmux_window then
					-- 			return nil, "AVANTE_TMUX_WINDOW environment variable is not set"
					-- 		end
					-- 		local command = params.command
					-- 		local full_command = string.format(
					-- 			"tmux send-keys -t %s 'rm -f /tmp/avante-status; %s | tee /tmp/avante-out; echo $? > /tmp/avante-status' C-m",
					-- 			tmux_window, command)
					-- 		local result = vim.fn.system(full_command)
					-- 		if vim.v.shell_error ~= 0 then
					-- 			return nil, result
					-- 		end

					-- 		-- Wait for the command to execute, checking every 500ms for up to 5 seconds
					-- 		local timeout = 5000
					-- 		local interval = 500
					-- 		local elapsed = 0
					-- 		while elapsed < timeout do
					-- 			vim.wait(interval)
					-- 			elapsed = elapsed + interval
					-- 			if vim.fn.filereadable("/tmp/avante-status") == 1 then
					-- 				break
					-- 			end
					-- 		end

					-- 		-- Retrieve the result from the /tmp/out file
					-- 		local output = vim.fn.readfile("/tmp/avante-out")
					-- 		if vim.v.shell_error ~= 0 then
					-- 			return nil, "Failed to read output file"
					-- 		end
					-- 		-- how to print a table
					-- 		-- Check if the command finished successfully
					-- 		local status = vim.fn.readfile("/tmp/avante-status")
					-- 		if vim.v.shell_error ~= 0 then
					-- 			return table.concat(output, "\n"), -1
					-- 		end
					-- 		-- Join the output lines into a single string
					-- 		return table.concat(output, "\n")
					-- 	end,
					-- },
				},
			})
		end
		,

		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick",      -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp",           -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua",           -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua",     -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
				keys = {
					-- suggested keymap
					{ "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
				},
			},
		},
	},
}
