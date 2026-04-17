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
      -- This overrides your options.lua automatically [cite: 17, 20]
      vim.opt.termguicolors = false 
      vim.o.background = "dark" 
    end,
    config = function()
      vim.cmd([[colorscheme ansi]])
    end,
  },
}