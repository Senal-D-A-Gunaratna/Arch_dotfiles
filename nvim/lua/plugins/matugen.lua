-- ~/.config/nvim/lua/plugins/matugen.lua
-- Drop-in replacement — no base16, no hardcoded hex values
-- Colors are read at startup from ~/.config/matugen/themes/code-colors.json
-- Hot reload on SIGUSR1 (sent automatically by matugen post_hook)

local theme = require("matugen-theme")

return {
  -- Disable base16 entirely
  { "RRethy/nvim-base16", enabled = false },

  -- Tell LazyVim to use our colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        theme.load()
      end,
    },
  },
}
