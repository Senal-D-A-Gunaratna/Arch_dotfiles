return {
  {
    "neovim/nvim-lspconfig",
    opts = {},
    config = function()
      vim.lsp.config("cspell_ls", {
        cmd = { "/home/senal/.npm-global/bin/cspell-lsp", "--stdio" },
        filetypes = {
          "lua",
          "python",
          "javascript",
          "typescript",
          "html",
          "css",
          "json",
          "yaml",
          "markdown",
          "gitcommit",
        },
        root_markers = { ".git" },
      })
      vim.lsp.enable("cspell_ls")
    end,
  },

  -- Map <leader>ca to code actions
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
      },
    },
  },
}
