return {
  {
    "adriancmiranda/glimpse.nvim",
    ft = { "oil", "neo-tree" },
    event = {
      "BufReadPost *.png",
      "BufReadPost *.jpg",
      "BufReadPost *.jpeg",
      "BufReadPost *.gif",
      "BufReadPost *.bmp",
      "BufReadPost *.webp",
      "BufReadPost *.avif",
      "BufReadPost *.svg",
      "BufReadPost *.pdf",
      "BufReadPost *.ttf",
      "BufReadPost *.otf",
      "BufReadPost *.crt",
      "BufReadPost *.pem",
      "BufReadPost *.zip",
      "BufReadPost *.tar",
      "BufReadPost *.tgz",
      "BufReadPost *.jar",
      "BufReadPost *.war",
      "BufReadPost *.apk",
      "BufReadPost *.db",
      "BufReadPost *.sqlite",
      "BufReadPost *.sqlite3",
    },
    opts = {
      strategy = "auto", -- 'auto' | 'inline' | 'pane'
      pane_position = "right", -- 'right' | 'bottom'
      pane_size = 40, -- split/pane size percentage
      inline = {
        rerender_on_tab = true, -- re-render when switching back to image tab
        close_with_q = true, -- map key to close image buffer
      },
      keys = {
        preview = "<leader>p", -- preview image/video side by side (Oil)
        open = ";", -- open image in tab or video with external player (Oil)
        close = "q", -- close image buffer
      },
      debounce = {
        prefetch = 200, -- ms before pre-converting on cursor move
        resize = 100, -- ms before re-rendering on resize
      },
      cell_size = {
        width = 20, -- estimated pixels per terminal column
        height = 40, -- estimated pixels per terminal row
      },
      cache_dir = vim.fn.stdpath("cache") .. "/glimpse",
      cache_max_age_days = 7, -- auto-remove cached files older than N days (0 to disable)
      max_file_size = 50 * 1024 * 1024, -- skip files larger than 50MB
      loading_text = "  ⏳ Loading...",
      formats = { -- supported image extensions
        ".png",
        ".jpg",
        ".jpeg",
        ".gif",
        ".bmp",
        ".webp",
        ".avif",
        ".svg",
        ".pdf",
        ".pict",
      },
      video_formats = { -- supported video extensions (requires ffmpeg)
        ".mp4",
        ".mkv",
        ".avi",
        ".mov",
        ".webm",
        ".flv",
        ".wmv",
        ".m4v",
      },
      video_open = nil, -- command or function to open videos externally
      -- string: 'open' (macOS), 'xdg-open' (Linux)
      -- function: fun(filepath) for custom logic
      -- nil: opens as buffer in Neovim
      archive_formats = { -- supported archive extensions (preview only, no extraction)
        ".zip",
        ".tar",
        ".tar.gz",
        ".tgz",
        ".tar.bz2",
        ".tar.xz",
        ".txz",
        ".jar",
        ".war",
        ".apk",
      },
      integrations = {
        oil = true, -- keymaps in Oil
        neotree = { -- Neo-tree integration
          enable = false, -- enable auto-preview in Neo-tree
          auto_preview = true, -- preview on cursor move (set false to disable)
        },
        telescope = true, -- enables image/video previews in :Telescope find_files
      },
    },
  },
}
