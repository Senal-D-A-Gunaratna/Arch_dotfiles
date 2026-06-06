-- Fix for the dimming issue in image_8afe44.png
-- We hook into the ColorScheme event so it reliably overrides any theme settings.
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Force hidden and untracked files to use standard text highlights
    vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { link = "Normal" })
    vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { link = "Normal" })

    -- Keep truly git-ignored files dimmed out like in VS Code
    vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { link = "Comment" })
  end,
})

-- Trigger it once immediately in case the colorscheme is already loaded
vim.cmd([[doautocmd ColorScheme]])

return {
  "folke/snacks.nvim",
  opts = {

    --disable scroll for mini.animate
    scroll = { enabled = false },

    -- display images in editor
    image = { enabled = true },

    -- Neovim logo
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[
        ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
        ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
        ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
        ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
        ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
        ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]],
      },
    },

    picker = {
      sources = {
        explorer = {
          ignored = true, -- Shows git-ignored files
          hidden = true, -- Shows dotfiles
        },
      },
    },
  },
}
