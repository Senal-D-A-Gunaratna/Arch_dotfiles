return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
        "debugpy",
        "js-debug-adapter",
        "cspell",
        "cspell-lsp",
        "marksman",
        "yaml-language-server",
        "css-lsp",
        "taplo",
        "pyright",
        "ruff",
        "oxlint",
      },
    },
  },

  {
    "Senal-D-A-Gunaratna/swapson.nvim",
    opts = {
      npm = {
        enabled = true,
        tool = "bun",
        patch_version_lookup = true,
      },
      pip = {
        enabled = true,
        tool = "uv",
      },
    },
  },

  {
    "Senal-D-A-Gunaratna/hyprfade.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      opacity = 0.7, -- normal editing opacity
      opacity_inactive = 0.75, -- opacity for inactive windows
      term_names = { "kitty" },
    },
    keys = {
      { "<leader>uo", "<cmd>HyprfadeToggle<cr>", desc = "Toggle window opacity" },
    },
  },

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
