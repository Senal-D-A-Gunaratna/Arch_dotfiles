return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "ts_ls",
        "rust_analyzer",
        "html",
      },
    },
  },
}
