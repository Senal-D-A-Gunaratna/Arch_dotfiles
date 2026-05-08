-- ~/.config/nvim/lua/plugins/avante.lua

if not vim.env.GEMINI_API_KEY or vim.env.GEMINI_API_KEY == "" then
  vim.env.GEMINI_API_KEY = vim.fn.system("bash -c 'source ~/.zshrc 2>/dev/null && echo -n $GEMINI_API_KEY'")
end

if not vim.env.MOONSHOT_API_KEY or vim.env.MOONSHOT_API_KEY == "" then
  vim.env.MOONSHOT_API_KEY = vim.fn.system("bash -c 'source ~/.zshrc 2>/dev/null && echo -n $MOONSHOT_API_KEY'")
end

return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- this file can contain specific instructions for your project
    instructions_file = "avante.md",

    -- active provider
    provider = "moonshot",
    -- provider = "gemini",

    providers = {
      moonshot = {
        endpoint = "https://api.moonshot.ai/v1",
        model = "kimi-k2.6",
        timeout = 30000,
        api_key_name = "MOONSHOT_API_KEY",
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 32768,
        },
      },
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-2.5-flash",
        timeout = 30000,
        api_key_name = "GEMINI_API_KEY",
        extra_request_body = {
          temperature = 0.75,
          generationConfig = {
            maxOutputTokens = 65536,
          },
        },
      },
    },

    behaviour = {
      auto_suggestions = true,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
      minimize_diff = true,
    },

    file_selector = {
      provider = "telescope", -- or "fzf" / "mini.pick"
    },
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-mini/mini.pick",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "stevearc/dressing.nvim",
    "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
