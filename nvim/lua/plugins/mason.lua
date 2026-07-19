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
      },
    },
  },
  -- 2. mason-lspconfig: LSP servers not covered by extras
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "bashls",
        "cssls",
      },
      automatic_enable = true, -- Mason v2 activation
    },
  },
}
