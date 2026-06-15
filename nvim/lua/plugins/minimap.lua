return {
  {
    "Isrothy/neominimap.nvim", -- Fixed repository name
    version = "v3.*",
    enabled = true,
    lazy = false,
    keys = {
      -- Fixed command capitalization
      { "<leader>uM", "<cmd>Neominimap Toggle<cr>", desc = "Toggle Minimap" },
    },
    init = function()
      vim.g.neominimap_singleton = true
    end,
  },
}
