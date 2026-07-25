return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
        "debugpy",
        "js-debug-adapter",
        "cspell",
        "cspell-lsp",
        "marksman",
        "yaml-language-server",
        "css-lsp",
        "taplo",
        "pyright",
      },
    },
  },
}
