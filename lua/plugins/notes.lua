return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		'MeanderingProgrammer/render-markdown.nvim',
		-- enabled = false,
		config = function()
			require('render-markdown').setup({
				file_types = { "markdown", "Avante" },
				heading = {
					backgrounds = {}
				},
				checkbox = {
					enabled = true,
					unchecked = {
						-- Replaces '[ ]' of 'task_list_marker_unchecked'
						icon = '󰄱 ',
						-- Highlight for the unchecked icon
						highlight = 'RenderMarkdownUnchecked',
						-- Highlight for item associated with unchecked checkbox
						scope_highlight = nil,
					},
					checked = {
						-- Replaces '[x]' of 'task_list_marker_checked'
						icon = '',
						-- Highlight for the checked icon
						highlight = 'RenderMarkdownChecked',
						-- Highlight for item associated with checked checkbox
						scope_highlight = nil,
					},
					custom = {
						todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
						in_progress = { raw = "[>]", rendered = "", hl_group = "ObsidianRightArrow" },
						canceled = { raw = "[~]", rendered = "󰰱", hl_group = "ObsidianTilde" },
						important = { raw = "[!]", rendered = "", hl_group = "ObsidianImportant" },
					}
				},
			})
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		enabled = false,
		version = "3.9.2", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		--   -- refer to `:h file-pattern` for more examples
		--   "BufReadPre path/to/my-vault/*.md",
		--   "BufNewFile path/to/my-vault/*.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/Documents/notes",
					strict = false
				},
				{
					name = "work",
					path = "~/Documents/notes/research",
					strict = false
				},
			},
		},
		ui = {
			enable = false, -- set to false to disable all additional syntax features
			update_debounce = 200, -- update delay after a text change (in milliseconds)
			max_file_length = 5000, -- disable UI features for files with more than this many lines
			-- Define how various check-boxes are displayed
			checkboxes = {
				-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
				[">"] = { char = "", hl_group = "ObsidianRightArrow" },
				["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
				["!"] = { char = "", hl_group = "ObsidianImportant" },
				-- Replace the above with this if you don't have a patched font:
				-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
				-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

				-- You can also add more custom ones...
			},
		},
	},
}
