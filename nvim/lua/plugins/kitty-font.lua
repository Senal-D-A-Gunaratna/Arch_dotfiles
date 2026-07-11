return {
  {
    "nitinbhat972/kitty-font.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      font_family = "JetBrainsMono Nerd Font",
      font_size = 11.8,
      restore_on_exit = true,
    },
    keys = {
      {
        "<leader>k=",
        function()
          local kf = require("kitty-font")
          kf.config.font_size = kf.config.font_size + 1
          kf.apply({ silent = true })
          vim.notify("Kitty font size: " .. kf.config.font_size)
        end,
        desc = "Kitty font size +1",
      },
      {
        "<leader>k-",
        function()
          local kf = require("kitty-font")
          kf.config.font_size = math.max(4, kf.config.font_size - 1)
          kf.apply({ silent = true })
          vim.notify("Kitty font size: " .. kf.config.font_size)
        end,
        desc = "Kitty font size -1",
      },
      {
        "<leader>kk",
        function()
          local kf = require("kitty-font")
          kf.config.font_family = "JetBrainsMono Nerd Font"
          kf.config.font_size = 11.8
          kf.apply({ silent = true })
          vim.notify("Reset to editor defaults")
        end,
        desc = "Reset to editor defaults",
      },
      {
        "<leader>kf",
        function()
          require("kitty-font").pick()
        end,
        desc = "Pick Kitty font",
      },
      {
        "<leader>kr",
        function()
          require("kitty-font").reset()
        end,
        desc = "Reset to kitty config",
      },
    },
  },
}
