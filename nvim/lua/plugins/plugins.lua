return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "AI", icon = "󰚩" },
        { "<leader>at", desc = "Toggle AI Completion", icon = "" },
        { "<leader>k", desc = "Kitty", icon = "󰍹" },
      },
    },
  },

  {
    "supermaven-inc/supermaven-nvim",
    keys = {
      { "<leader>at", "<cmd>SupermavenToggle<cr>", desc = "Toggle AI Completion" },
    },
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<Tab>", -- Hits Tab to accept the ghost text
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
      })
    end,
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
    },
    config = function()
      -- Optional: Persistent undo so history survives restarts
      vim.opt.undofile = true
    end,
  },

  {
    "Isrothy/neominimap.nvim",
    version = "v3.*",
    enabled = true,
    lazy = false,
    keys = {
      { "<leader>uM", "<cmd>Neominimap Toggle<cr>", desc = "Toggle Minimap" },
    },
    init = function()
      vim.g.neominimap = {
        auto_enable = true,
      }
    end,
  },
}
