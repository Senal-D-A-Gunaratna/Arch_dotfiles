-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--Snacks explorer mousescroll set to 1 line pre tick
vim.opt.mousescroll = "ver:1,hor:6"

--  sidekick gemini path issue fix
local npm_global = vim.fn.expand("$HOME") .. "/.npm-global/bin"
if not vim.env.PATH:find(npm_global, 1, true) then
  vim.env.PATH = npm_global .. ":" .. vim.env.PATH
end