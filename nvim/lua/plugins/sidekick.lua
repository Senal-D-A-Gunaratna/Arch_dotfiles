return {
  {
    "folke/sidekick.nvim",
    opts = {},
    keys = {
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick toggle CLI",
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").select()
        end,
        desc = "Sidekick select tool",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").focus()
        end,
        mode = { "n", "t", "i", "x" },
        desc = "Sidekick focus",
      },
      {
        "<leader>ai",
        function()
          Snacks.terminal("agy", { win = { position = "right", width = 80 } })
        end,
        desc = "Antigravity CLI",
      },
    },
  },
}
