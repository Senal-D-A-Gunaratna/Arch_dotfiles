-- load the matugen theme

if false then return {} end -- Set to false to go back to "Normal" mode

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function() end, -- noop, matugen handles it
    },
  },
  {
    dir = vim.fn.stdpath("config"),
    name = "matugen-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("plugins.matugen").load()
    end,
  },
}
