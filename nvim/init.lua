-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Load custom matugen colorscheme
pcall(function()
  require("config.matugen").load()
end)
