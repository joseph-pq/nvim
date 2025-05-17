return {
  {
    "jmbuhr/telescope-zotero.nvim",
    dev = true,
    dependencies = {
      { "kkharji/sqlite.lua" },
    },
    keys = {
      {
        "<leader>tz",
        function()
          require("telescope").extensions.zotero.zotero()
        end,
        desc = "Search Zotero",
      },
    },
    config = function()
      local telescope = require("telescope")
      -- other telescope setup
      -- ...
      telescope.load_extension("zotero")
    end,
  },
}
