-- ~/.config/nvim/lua/plugins/matugen.lua
local ok, theme = pcall(require, "matugen_theme")

return {
  { "RRethy/nvim-base16", enabled = false },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "matugen",
    },
  },

  {
    -- Dummy plugin entry just to trigger our theme on startup
    dir = vim.fn.stdpath("config"),
    name = "matugen-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("matugen_theme").load()
    end,
  },
}
