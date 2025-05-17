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

## Language Servers

+ pyright
+ rust_analyzer
+ texlab
