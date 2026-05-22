return {
  {
    "matugen",
    dir = vim.fn.stdpath("config") .. "/lua/matugen",
    lazy = false,
    priority = 1000,
    opts = {
      json_path = vim.fn.expand("~/.config/matugen/themes/code-colors.jsonc"),
    },
  },
}
