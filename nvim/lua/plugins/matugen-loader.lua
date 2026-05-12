-- load the matugen theme

local enabled = true -- Set to false to disable matugen theme

if not enabled then
  vim.notify("matugen: theme disabled", vim.log.levels.WARN)
  return {}
end

return {
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
