return {
  -- 1. Mason: non-LSP tools only (formatters, linters, DAP)
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "prettier",
        "stylua",
        "shfmt",
        "shellcheck",
        "markdownlint",
        "debugpy",
        "js-debug-adapter",
        "codelldb",
      },
    },
  },

  -- 2. mason-lspconfig: LSP servers — must declare deps for load order
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "rust_analyzer",
        "vtsls",
        "pyright",
        "ruff",
        "lua_ls",
        "bashls",
        "taplo",
        "cssls",
        "jsonls",
        "tailwindcss",
      },
      automatic_enable = true,  -- v2 correct option (not automatic_installation)
    },
  },
}
