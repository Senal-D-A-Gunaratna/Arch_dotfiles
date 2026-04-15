-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable True Color support so it falls back to your terminal (Kitty)
vim.opt.termguicolors = false
-- Ensure Neovim knows your terminal supports at least 256 colors for compatibility
-- but we will limit the theme to 16.
vim.cmd("set t_Co=256")