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
    preferred_picker = "snacks",
    preferred_completion = "blink",
    default_global_keymaps = true,

    -- Server configuration
    server = {
      url = nil, -- URL/hostname (e.g., 'http://192.168.1.100', 'localhost', 'https://myserver.com')
      port = nil, -- Port number (e.g., 8080), 'auto' for random port
      timeout = 5, -- Health check timeout in seconds when connecting
      spawn_command = nil, -- Optional function to start the server: function(port, url) ... end
      auto_kill = true, -- Kill spawned servers when last nvim instance exits (default: true)
      -- Only applies to servers spawned by the plugin with spawn_command/kill_command
      path_map = nil, -- Map host paths to server paths: string ('/app') or function(path) -> string
      username = nil, -- Username for Basic auth. Falls back to OPENCODE_SERVER_USERNAME env var, then "opencode"
      password = nil, -- Password for Basic auth. Falls back to OPENCODE_SERVER_PASSWORD env var
    },

    ui = {
      window_width = 0.30, -- 👈 Side panel width (40% of screen)
      zoom_width = 0.80, -- 👈 Width when zoomed
      input_position = "bottom", -- Keeps the input at the bottom of the panel
      input = {
        text = {
          wrap = true, -- Wraps long lines in the input window
        },
      },
    },

    -- Override the default toggle keys.
    keymap = {
      editor = {
        ["<leader>ai"] = { "toggle" },
        ["<leader>az"] = { "toggle_zoom" },
      },
    },
  },
}
