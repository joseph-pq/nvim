# Joseph's Neovim configurations

<a href="https://dotfyle.com/joseph-pq/nvim"><img src="https://dotfyle.com/joseph-pq/nvim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/joseph-pq/nvim"><img src="https://dotfyle.com/joseph-pq/nvim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/joseph-pq/nvim"><img src="https://dotfyle.com/joseph-pq/nvim/badges/plugin-manager?style=flat" /></a>


## Install Instructions

 > Install requires Neovim 0.9+. Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone git@github.com:joseph-pq/nvim ~/.config/joseph-pq/nvim
```

Open Neovim with this config:

```sh
NVIM_APPNAME=joseph-pq/nvim/ nvim
```

## Setup

### Clangd when running embedded c code

When I'm working with embedded C projects, I should make some configurations
in my clangd. For example, in my previos coc-settings.json configuration, I
used to have these confiruations:

```json
{
	"clangd.checkUpdates": true,
	"clangd.arguments": [
		"--enable-config",
		"--background-index",
		"--query-driver=~/Programs/gcc-arm-none-eabi-9-2020-q2-update/bin/arm-none-eabi-gcc,~/.espressif/tools/xtensa-esp32-elf/esp-2021r2-8.4.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc"
	],
	"clangd.path": "~/.config/coc/extensions/coc-clangd-data/install/15.0.6/clangd_15.0.6/bin/clangd",
}
```

## Plugins

### ai

+ [CopilotC-Nvim/CopilotChat.nvim](https://dotfyle.com/plugins/CopilotC-Nvim/CopilotChat.nvim)
+ [yetone/avante.nvim](https://dotfyle.com/plugins/yetone/avante.nvim)
### code-runner

+ [stevearc/overseer.nvim](https://dotfyle.com/plugins/stevearc/overseer.nvim)
+ [Vigemus/iron.nvim](https://dotfyle.com/plugins/Vigemus/iron.nvim)
### colorscheme

+ [folke/tokyonight.nvim](https://dotfyle.com/plugins/folke/tokyonight.nvim)
+ [rebelot/kanagawa.nvim](https://dotfyle.com/plugins/rebelot/kanagawa.nvim)
+ [catppuccin/nvim](https://dotfyle.com/plugins/catppuccin/nvim)
### comment

+ [JoosepAlviste/nvim-ts-context-commentstring](https://dotfyle.com/plugins/JoosepAlviste/nvim-ts-context-commentstring)
+ [folke/todo-comments.nvim](https://dotfyle.com/plugins/folke/todo-comments.nvim)
### completion

+ [hrsh7th/nvim-cmp](https://dotfyle.com/plugins/hrsh7th/nvim-cmp)
### debugging

+ [rcarriga/nvim-dap-ui](https://dotfyle.com/plugins/rcarriga/nvim-dap-ui)
+ [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)
+ [theHamsta/nvim-dap-virtual-text](https://dotfyle.com/plugins/theHamsta/nvim-dap-virtual-text)
### editing-support

+ [folke/zen-mode.nvim](https://dotfyle.com/plugins/folke/zen-mode.nvim)
+ [monaqa/dial.nvim](https://dotfyle.com/plugins/monaqa/dial.nvim)
+ [Wansmer/treesj](https://dotfyle.com/plugins/Wansmer/treesj)
### fuzzy-finder

+ [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)
### git

+ [sindrets/diffview.nvim](https://dotfyle.com/plugins/sindrets/diffview.nvim)
+ [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)
### icon

+ [kyazdani42/nvim-web-devicons](https://dotfyle.com/plugins/kyazdani42/nvim-web-devicons)
+ [nvim-tree/nvim-web-devicons](https://dotfyle.com/plugins/nvim-tree/nvim-web-devicons)
### indent

+ [lukas-reineke/indent-blankline.nvim](https://dotfyle.com/plugins/lukas-reineke/indent-blankline.nvim)
### keybinding

+ [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)
### lsp

+ [VonHeikemen/lsp-zero.nvim](https://dotfyle.com/plugins/VonHeikemen/lsp-zero.nvim)
+ [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)
+ [j-hui/fidget.nvim](https://dotfyle.com/plugins/j-hui/fidget.nvim)
+ [nvimtools/none-ls.nvim](https://dotfyle.com/plugins/nvimtools/none-ls.nvim)
### lsp-installer

+ [williamboman/mason.nvim](https://dotfyle.com/plugins/williamboman/mason.nvim)
### markdown-and-latex

+ [MeanderingProgrammer/render-markdown.nvim](https://dotfyle.com/plugins/MeanderingProgrammer/render-markdown.nvim)
+ [iamcco/markdown-preview.nvim](https://dotfyle.com/plugins/iamcco/markdown-preview.nvim)
### media

+ [3rd/image.nvim](https://dotfyle.com/plugins/3rd/image.nvim)
### note-taking

+ [nvim-neorg/neorg](https://dotfyle.com/plugins/nvim-neorg/neorg)
+ [epwalsh/obsidian.nvim](https://dotfyle.com/plugins/epwalsh/obsidian.nvim)
### nvim-dev

+ [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)
+ [folke/lazydev.nvim](https://dotfyle.com/plugins/folke/lazydev.nvim)
+ [folke/neodev.nvim](https://dotfyle.com/plugins/folke/neodev.nvim)
+ [MunifTanjim/nui.nvim](https://dotfyle.com/plugins/MunifTanjim/nui.nvim)
### plugin-manager

+ [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)
### programming-languages-support

+ [akinsho/flutter-tools.nvim](https://dotfyle.com/plugins/akinsho/flutter-tools.nvim)
### snippet

+ [L3MON4D3/LuaSnip](https://dotfyle.com/plugins/L3MON4D3/LuaSnip)
+ [rafamadriz/friendly-snippets](https://dotfyle.com/plugins/rafamadriz/friendly-snippets)
### statusline

+ [nvim-lualine/lualine.nvim](https://dotfyle.com/plugins/nvim-lualine/lualine.nvim)
+ [AndreM222/copilot-lualine](https://dotfyle.com/plugins/AndreM222/copilot-lualine)
### syntax

+ [nvim-treesitter/nvim-treesitter-textobjects](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-textobjects)
+ [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)
### test

+ [nvim-neotest/neotest](https://dotfyle.com/plugins/nvim-neotest/neotest)
### utility

+ [stevearc/dressing.nvim](https://dotfyle.com/plugins/stevearc/dressing.nvim)
## Language Servers

+ pyright
+ rust_analyzer
+ texlab


 This readme was generated by [Dotfyle](https://dotfyle.com)
