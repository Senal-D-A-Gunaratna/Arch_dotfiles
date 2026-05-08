{
  "yetone/avante.nvim",
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  event = "VeryLazy",
  version = false,
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    instructions_file = "avante.md",

    -- Set Gemini as the active provider
    provider = "gemini",

    providers = {
      -- Your existing providers (kept for easy switching)
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        timeout = 30000,
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
      },
      moonshot = {
        endpoint = "https://api.moonshot.ai/v1",
        model = "kimi-k2-0711-preview",
        timeout = 30000,
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 32768,
        },
      },

      -- Gemini 2.5 Flash provider
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-2.5-flash-preview-05-20",
        timeout = 30000,
        extra_request_body = {
          temperature = 0.75,
          generationConfig = {
            maxOutputTokens = 65536, -- 2.5 Flash supports a large output window
          },
        },
      },
    },

    -- Behaviour tweaks for vibe-coding
    behaviour = {
      auto_suggestions = true,        -- inline ghost-text suggestions as you type
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
      minimize_diff = true,           -- only show changed lines in diffs
    },

    -- File selector: pick whichever you have installed
    file_selector = {
      provider = "telescope", -- or "fzf" / "mini.pick"
    },
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-mini/mini.pick",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvi
