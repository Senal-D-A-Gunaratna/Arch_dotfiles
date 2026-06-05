return {
  "folke/snacks.nvim",
  opts = {
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

    -- Add your picker configurations here
    picker = {
      sources = {
        explorer = {
          ignored = true, -- Shows git-ignored files by default (like VS Code)
          hidden = true, -- Optional: Shows dotfiles like .env, .gitignore, etc.
        },
      },
    },
  },
}
