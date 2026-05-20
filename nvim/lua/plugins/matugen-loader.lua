-- load the matugen theme

local enabled = true -- Set to false to disable matugen theme

if not enabled then
  vim.notify("matugen: theme disabled", vim.log.levels.WARN)
  return {}
end

return {
  {
    "matugen-theme",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 1000,
    config = function()
      require("config.matugen").load()
    end,
  },
}
