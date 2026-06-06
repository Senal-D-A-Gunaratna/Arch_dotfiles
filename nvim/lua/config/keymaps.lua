-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Open Antigravity CLI split on the right side taking up exactly 1/4 of the total screen
vim.keymap.set("n", "<leader>ai", function()
  -- Calculate 25% of the total screen columns
  local width = math.floor(vim.go.columns * 0.30)

  -- Open the split forcing the calculated column width on the far right
  vim.cmd("botright " .. width .. "vsplit")

  -- Open the terminal running agy
  vim.cmd("term agy")

  -- Start in terminal insert mode immediately
  vim.cmd("startinsert")
end, { desc = "Antigravity CLI" })
