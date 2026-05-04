return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "pyright",
        "typescript-language-server",
        "rust-analyzer",
        "html-lsp",
      },
    },
  },
}
