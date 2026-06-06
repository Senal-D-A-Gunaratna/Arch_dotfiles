-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--Snacks explorer mousescroll set to 1 line pre tick
vim.opt.mousescroll = "ver:1,hor:6"

--npm global bin path
vim.env.PATH = vim.env.PATH .. ":/home/senal/.npm-global/bin"
