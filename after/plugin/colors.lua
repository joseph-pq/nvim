function ColorMyPencils(color)
  color = color or "gruvbox"
  vim.cmd.colorscheme(color)

  -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
-- if env NVIM_BG_TRANSPARENT is True, then set bg to none
-- vim.env.NVIM_BG_TRANSPARENT = "True"
-- if vim.env.NVIM_BG_TRANSPARENT == "True" then
--     vim.cmd('hi Normal ctermbg=NONE guibg=NONE')
--     vim.cmd('hi NonText ctermbg=NONE guibg=NONE')
-- end

ColorMyPencils("tokyonight-night")
