return {
  -- 1. Mason: Tools not covered by extras (linters, DAP)
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
        "debugpy",
        "js-debug-adapter",
        "cspell",
        "cspell-lsp",
        -- "yaml-language-server",
        -- "css-lsp",
      },
    },
  },
}
