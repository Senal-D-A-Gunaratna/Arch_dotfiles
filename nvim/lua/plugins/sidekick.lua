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
        opencode = {
          cmd = { "/usr/bin/opencode" },
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
        require("sidekick.cli").toggle({ name = "opencode", focus = true })
      end,
      desc = "Toggle Opencode CLI",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "x", "n" },
      desc = "Send This to Opencode",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "Send File to Opencode",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = { "x" },
      desc = "Send Selection to Opencode",
    },
  },
}
