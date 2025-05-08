return {

	-- I have a separate config.mappings file where I require which-key.
	-- With lazy the plugin will be automatically loaded when it is required somewhere
	{ "folke/which-key.nvim",   lazy = true },

	{
		"nvim-neorg/neorg",
		-- lazy-load on filetype
		ft = "norg",
		-- options for neorg. This will automatically call `require("neorg").setup(opts)`
		opts = {
			load = {
				["core.defaults"] = {},
			},
		},
	},

	{
		"dstein64/vim-startuptime",
		-- lazy-load on a command
		cmd = "StartupTime",
		-- init is called during startup. Configuration for vim plugins typically should be set in an init function
		init = function()
			vim.g.startuptime_tries = 10
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
	},

	-- if some code requires a module from an unloaded plugin, it will be automatically loaded.
	-- So for api plugins like devicons, we can always set lazy=true
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({ default = true })
		end
	},

	-- you can use the VeryLazy event for things that can
	-- load later and are not important for the initial UI
	{ "stevearc/dressing.nvim", event = "VeryLazy" },

	{
		"Wansmer/treesj",
		keys = {
			{ "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
		},
		opts = { use_default_keymaps = false, max_join_length = 150 },
	},

	{
		"monaqa/dial.nvim",
		-- lazy-load on keys
		-- mode is `n` by default. For more advanced options, check the section on key mappings
		keys = { "<C-a>", { "<C-x>", mode = "n" } },
	},
	-- local plugins can also be configured with the dev option.
	-- With the dev option, you can easily switch between the local and installed version of a plugin
	-- Highlight, edit, and navigate code
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = { 'nvim-treesitter' }
	},
	--- This is used for my own plugins
	{ 'nvim-treesitter/playground' },
	{ 'mbbill/undotree' },

	{
		'nvim-lualine/lualine.nvim', -- Fancier status line
		dependencies = { 'kyazdani42/nvim-web-devicons', opt = true }
	},

	{ 'lukas-reineke/indent-blankline.nvim' }, -- Indent guides
	{ 'tpope/vim-sleuth' },                   -- Automatically set indent settings
	{ 'tpope/vim-commentary' },
	{ 'tpope/vim-surround' },

	-- LSP
	{ 'williamboman/mason.nvim' },
	-- {
	-- 	'VonHeikemen/lsp-zero.nvim',
	-- 	dependencies = {
	-- 		-- LSP Support
	-- 		{ 'neovim/nvim-lspconfig' },
	-- 		{ 'williamboman/mason.nvim' },
	-- 		{ 'williamboman/mason-lspconfig.nvim' },

	-- 		-- Autocompletion
	-- 		{ 'hrsh7th/nvim-cmp' }, -- Autocompletion
	-- 		{ 'hrsh7th/cmp-buffer' },
	-- 		{ 'hrsh7th/cmp-path' },
	-- 		{ 'saadparwaiz1/cmp_luasnip' },
	-- 		{ 'hrsh7th/cmp-nvim-lsp' },
	-- 		{ 'hrsh7th/cmp-nvim-lua' },

	-- 		-- Snippets
	-- 		{
	-- 			'L3MON4D3/LuaSnip',
	-- 			build = "make install_jsregexp",
	-- 		},
	-- 		{ 'rafamadriz/friendly-snippets' },
	-- 	}
	-- },
	{ "folke/zen-mode.nvim" },

	{ 'christoomey/vim-system-copy' },
	{ 'vim-scripts/argtextobj.vim' },
	{ 'j-hui/fidget.nvim' },
	{ 'neomake/neomake' },
	-- tests
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
		}
	},
	-- misc
	{ -- execute some things
		'stevearc/overseer.nvim',
		config = function() require('overseer').setup() end
	},
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim"
		}
	},

	{ 'nvimtools/none-ls.nvim' },

	-- flutter
	{
		'akinsho/flutter-tools.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'stevearc/dressing.nvim', -- optional for vim.ui.select
		},
	},
	-- python repl
	{ 'Vigemus/iron.nvim' },

	-- datascience
	{ 'jpalardy/vim-slime' },

	{ 'preservim/vimux' },
	{
		'JoosepAlviste/nvim-ts-context-commentstring',
	},
	{
		'rcarriga/nvim-notify',
		enabled=false,
		config = function()
			vim.notify = require('notify')
			require("notify").setup({
				background_colour = "#000000",
				merge_duplicates = true,
			})
		end,
	},
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
		dependencies = {
			"nvim-telescope/telescope.nvim",
			-- "ibhagwan/fzf-lua",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lang = "python3",
		},
	},
	{
		"joseph-pq/markdown-import.nvim",
		opts = {
			mlflow_uri = "http://jupiter2.incor.usp.br:8080",
		},
	},
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true,   -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false,     -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},
}
