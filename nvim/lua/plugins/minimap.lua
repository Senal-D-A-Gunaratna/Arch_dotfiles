return {
  {
    -- FIXED: Changed from 'echasnovski/mini.map' to match the new repository structure
    "nvim-mini/mini.map",
    version = false,
    keys = {
      { "<leader>mm", "<cmd>lua MiniMap.toggle()<cr>", desc = "Toggle Minimap" },
    },
    opts = function()
      local map = require("mini.map")
      return {
        integration = {
          map.gen_integration.builtin_search(),
          map.gen_integration.gitsigns(),
          map.gen_integration.diagnostic(),
        },
        symbols = {
          encode = map.gen_encode_symbols.dot("2x2"),
        },
        window = {
          side = "right",
          width = 12,
        },
      }
    end,
    config = function(_, opts)
      require("mini.map").setup(opts)
    end,
  },
}
