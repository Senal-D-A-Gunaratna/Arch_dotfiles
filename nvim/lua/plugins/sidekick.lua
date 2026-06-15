return {
  "folke/sidekick.nvim",
  opts = {
    nes = { enabled = false },
    cli = {
      watch = true,
      win = {
        layout = "right",
        split = { width = 60 },
      },
      tools = {
        antigravity = {
          cmd = { "agy" },
        },
      },
      picker = "snacks",
    },
    copilot = {
      status = { enabled = false },
    },
  },
  keys = {
    {
      "<leader>ai",
      function()
        require("sidekick.cli").toggle({ name = "antigravity", focus = true })
      end,
      desc = "Toggle Antigravity",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "x", "n" },
      desc = "Send This to Antigravity",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "Send File to Antigravity",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = { "x" },
      desc = "Send Selection to Antigravity",
    },
  },
}
