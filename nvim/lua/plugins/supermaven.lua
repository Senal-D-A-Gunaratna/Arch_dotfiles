return {
  "supermaven-inc/supermaven-nvim",
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
