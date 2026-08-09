return {
  {
    "moyiz/git-dev.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>go",
        function()
          local repo = vim.fn.input("Repo URL: ")
          if repo ~= "" then
            require("git-dev").open(repo)
          end
        end,
        desc = "[O]pen a remote git repository",
      },
    },
    opts = {
      git = {
        base_uri_format = "%s", -- require full URI, no org/repo shorthand
      },
    },
  },
}
