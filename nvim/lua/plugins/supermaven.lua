return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter", -- Lazy loads the plugin when you enter insert mode
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>", -- Hits Tab to accept the ghost text
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
    })
  end,
}
