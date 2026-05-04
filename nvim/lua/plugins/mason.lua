return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- formatters / linters only here
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
}
