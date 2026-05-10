-- load the matugen theme

local enabled = true -- Set to false to go back to "Normal" mode

if not enabled then
  return {}
end

return {

  --local ok, theme = pcall(require, "matugen_theme")

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
      require("plugins.matugen").load()
    end,
  },
}
