-- load the matugen theme

local enabled = true -- Set to false to go back to "Normal" mode

if not enabled then
  return {}
end

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
