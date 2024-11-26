local ts_utils = require("nvim-treesitter.ts_utils")

local function get_item_chain()
  local node = ts_utils.get_node_at_cursor()
  if not node then
    return "No Treesitter node found at cursor"
  end

  local chain = {}
  local current_node = node

  -- Traverse up the tree to find the class and function nodes
  while current_node do
    local node_type = current_node:type()
    if node_type == "class_definition" then
      -- For Python, class names are identifiers
      local class_name = ts_utils.get_node_text(current_node:field("name")[1], 0)[1]
      table.insert(chain, 1, class_name)
    elseif node_type == "function_definition" then
      -- For Python, function names are identifiers
      local func_name = ts_utils.get_node_text(current_node:field("name")[1], 0)[1]
      table.insert(chain, 1, func_name)
    end
    current_node = current_node:parent()
  end

  -- Return the chain joined by ":"
  return table.concat(chain, ":")
end

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = {
			'filename',
			get_item_chain
		},
		lualine_x = {
			-- 'copilot',
			-- 'encoding',
			-- 'fileformat',
			'filetype',
		},
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}
