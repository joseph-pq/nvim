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
		-- opts = {
		-- 	spec = {
		-- 		{ "<leader>a", group = "ai" },
		-- 		{ "gm",        group = "+Copilot chat" },
		-- 		{ "gmh",       desc = "Show help" },
		-- 		{ "gmd",       desc = "Show diff" },
		-- 		{ "gmp",       desc = "Show system prompt" },
		-- 		{ "gms",       desc = "Show selection" },
		-- 		{ "gmy",       desc = "Yank diff" },
		-- 	},
		-- },
	},
	-- {
	-- 	'CopilotC-Nvim/CopilotChat.nvim',
	-- 	enable = false,
	-- 	dependencies = {
	-- 		{ "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 	},
	-- 	branch = "main",
	-- 	config = function(_, opts)
	-- 		local chat = require("CopilotChat")
	-- 		chat.setup(opts)
	-- 	end,
	-- 	event = "VeryLazy",
	-- 	keys = {
	-- 		-- Show help actions with telescope
	-- 		{
	-- 			"<leader>ah",
	-- 			function()
	-- 				local actions = require("CopilotChat.actions")
	-- 				require("CopilotChat.integrations.telescope").pick(actions.help_actions())
	-- 			end,
	-- 			desc = "CopilotChat - Help actions",
	-- 		},
	-- 		-- Show prompts actions with telescope
	-- 		{
	-- 			"<leader>ap",
	-- 			function()
	-- 				local actions = require("CopilotChat.actions")
	-- 				require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
	-- 			end,
	-- 			desc = "CopilotChat - Prompt actions",
	-- 		},
	-- 		{
	-- 			"<leader>ap",
	-- 			":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
	-- 			mode = "x",
	-- 			desc = "CopilotChat - Prompt actions",
	-- 		},
	-- 		-- Code related commands
	-- 		{ "<leader>ae", "<cmd>CopilotChatExplain<cr>",       desc = "CopilotChat - Explain code" },
	-- 		{ "<leader>at", "<cmd>CopilotChatTests<cr>",         desc = "CopilotChat - Generate tests" },
	-- 		{ "<leader>ar", "<cmd>CopilotChatReview<cr>",        desc = "CopilotChat - Review code" },
	-- 		{ "<leader>aR", "<cmd>CopilotChatRefactor<cr>",      desc = "CopilotChat - Refactor code" },
	-- 		{ "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
	-- 		-- Chat with Copilot in visual mode
	-- 		{
	-- 			"<leader>av",
	-- 			":CopilotChatVisual",
	-- 			mode = "x",
	-- 			desc = "CopilotChat - Open in vertical split",
	-- 		},
	-- 		{
	-- 			"<leader>ax",
	-- 			":CopilotChatInline<cr>",
	-- 			mode = "x",
	-- 			desc = "CopilotChat - Inline chat",
	-- 		},
	-- 		-- Custom input for CopilotChat
	-- 		{
	-- 			"<leader>ai",
	-- 			function()
	-- 				local input = vim.fn.input("Ask Copilot: ")
	-- 				if input ~= "" then
	-- 					vim.cmd("CopilotChat " .. input)
	-- 				end
	-- 			end,
	-- 			desc = "CopilotChat - Ask input",
	-- 		},
	-- 		-- Generate commit message based on the git diff
	-- 		{
	-- 			"<leader>am",
	-- 			"<cmd>CopilotChatCommit<cr>",
	-- 			desc = "CopilotChat - Generate commit message for staged changes",
	-- 		},
	-- 		-- Quick chat with Copilot
	-- 		{
	-- 			"<leader>ccq",
	-- 			function()
	-- 				local input = vim.fn.input("Quick Chat: ")
	-- 				if input ~= "" then
	-- 					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
	-- 				end
	-- 			end,
	-- 			desc = "CopilotChat - Quick chat",
	-- 		},
	-- 		-- Debug
	-- 		{ "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>",     desc = "CopilotChat - Debug Info" },
	-- 		-- Fix the issue with diagnostic
	-- 		{ "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
	-- 		-- Clear buffer and chat history
	-- 		{ "<leader>al", "<cmd>CopilotChatReset<cr>",         desc = "CopilotChat - Clear buffer and chat history" },
	-- 		-- Toggle Copilot Chat Vsplit
	-- 		{ "<leader>av", "<cmd>CopilotChatToggle<cr>",        desc = "CopilotChat - Toggle" },
	-- 		-- Copilot Chat Models
	-- 		{ "<leader>a?", "<cmd>CopilotChatModels<cr>",        desc = "CopilotChat - Select Models" },
	-- 	},
	-- },
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
		opts = {
			provider = "copilot",
			auto_suggestions_provider = nil,
			cursor_applying_provider = 'copilot',
			behaviour = {
				enable_cursor_planning_mode = true,
			},
			ollama = {
				endpoint = os.getenv("AVANTE_OLLAMA_ENDPOINT") or "http://172.22.132.234:11435",
				model = os.getenv("AVANTE_OLLAMA_MODEL") or "qwen2.5-coder:3b",
			},
			vendors = {
				groq = { -- define groq provider
					__inherited_from = 'openai',
					endpoint = 'https://api.groq.com/openai/v1/',
					model = 'llama-3.3-70b-versatile',
					max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
				},
			},
			rag_service = {
				enabled = os.getenv("AVANTE_RAG_HOST_MOUNT") ~= nil, -- Enables the RAG service only if the environment variable exists
				host_mount = os.getenv("AVANTE_RAG_HOST_MOUNT"), -- Host mount path for the rag service
				provider = "ollama",                             -- The provider to use for RAG service (e.g. openai or ollama)
				llm_model = os.getenv("AVANTE_OLLAMA_MODEL"),    -- The LLM model to use for RAG service
				embed_model = "nomic-embed-text",                                -- The embedding model to use for RAG service
				endpoint = os.getenv("AVANTE_OLLAMA_ENDPOINT"),  -- The API endpoint for RAG service
			},
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
