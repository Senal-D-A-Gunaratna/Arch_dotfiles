return {
  -- 1. Disable the default LazyVim theme loading
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function() end, -- This stops LazyVim from forcing a theme
    },
  },

  -- 2. Use a theme that strictly follows terminal ANSI colors
  {
    "stevedylandev/ansi-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme ansi]])
    end,
  },
}
