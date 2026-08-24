return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      transparent_background = true,
    },
  },
  {
    "navarasu/onedark.nvim",
    lazy = true,
    opts = {
      transparent = true,
      style = "warmer",
    },
  },
  {
    "Aejkatappaja/cendre",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = true,
      background = "hard",
      italic_virtual_text = false,
    },
  },
  {
    'uloco/bluloco.nvim',
    lazy = true,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      -- your optional config goes here, see below.
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    priority = 1000, -- Ensure it loads first
  },
}
