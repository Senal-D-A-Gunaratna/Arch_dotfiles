return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "ts_ls",         -- was typescript-language-server
        "rust_analyzer", -- was rust-analyzer
        "html",          -- was html-lsp
      },
    },
  },
}
