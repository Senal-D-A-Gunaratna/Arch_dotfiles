return {
  {
    "matugen.nvim",
    dir = vim.fn.stdpath("config") .. "/matugen.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      jsonc_path = vim.fn.expand("~/.config/matugen/themes/code-colors.jsonc"),
    },
    config = function(_, opts)
      require("matugen").setup(opts)
      vim.cmd.colorscheme("matugen")
    end,
  },
}
