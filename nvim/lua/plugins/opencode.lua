return {
  "sudo-tee/opencode.nvim",
  -- Load the plugin only when the Opencode command is used or a specific key is hit.
  -- This keeps your startup time fast.
  cmd = { "Opencode" },
  keys = {
    { "<leader>ai", desc = "Toggle OpenCode" },
    { "<leader>oz", desc = "Toggle OpenCode Zoom" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
        file_types = { "markdown", "opencode_output" },
      },
    },
    -- Optional but recommended for better completion/pickers:
    "saghen/blink.cmp",
    "folke/snacks.nvim",
  },
  opts = {
    -- Point directly to the Bun-installed binary
    opencode_executable = "/home/senal/.cache/.bun/bin/opencode",

    -- Recommended optional settings for a smoother experience
    preferred_picker = "snacks", -- uses your snacks picker if available
    preferred_completion = "blink",
    default_global_keymaps = true, -- Keep the other default mappings

    ui = {
      window_width = 0.40, -- 👈 Side panel width (40% of screen)
      zoom_width = 0.80, -- 👈 Width when zoomed
      input_position = "bottom", -- Keeps the input at the bottom of the panel
      input = {
        text = {
          wrap = true, -- Wraps long lines in the input window
        },
      },
    },

    -- This is where we override the default toggle keys.
    keymap = {
      editor = {
        -- Default is <leader>og, we change it to <leader>ai
        ["<leader>ai"] = { "toggle" },
        -- Add a key to toggle zoom
        ["<leader>oz"] = { "toggle_zoom" },
      },
    },
  },
}
