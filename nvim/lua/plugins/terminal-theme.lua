local enabled = true -- Set to false to go back to "Normal" mode

if not enabled then
  return {}
end

return {
  -- 1. Force LazyVim to use your ANSI theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ansi",
    },
  },

  -- 2. The ANSI theme plugin with the automatic override
  {
    "stevedylandev/ansi-nvim",
    lazy = false,
    priority = 1000,
    init = function()
      -- These only run if 'enabled' is true
      vim.opt.termguicolors = false 
      vim.o.background = "dark" 
    end,
    config = function()
      vim.cmd([[colorscheme ansi]])
    end,
  },
}