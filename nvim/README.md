# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Matugen theming

the theming is dun by making Neovim directly use the terminal color palate via a custom plugin

[Plugin](/nvim/lua/plugins/terminal-theme.lua)

also add this code snippet to your (nvim/lua/config/options.lua)

```lua
-- Disable True Color support so it falls back to your terminal
vim.opt.termguicolors = false
-- Ensure Neovim knows your terminal supports at least 256 colors for compatibility
-- but we will limit the theme to 16.
vim.cmd("set t_Co=256")
```