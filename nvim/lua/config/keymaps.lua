-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Helper function for shorter keymaps
local map = vim.keymap.set

-- CodeBook: Add all unknown words to dictionary
map("n", "<leader>cA", function()
  local diagnostics = vim.diagnostic.get(0, { source = "codebook" })
  if #diagnostics == 0 then
    vim.notify("No CodeBook diagnostics", vim.log.levels.INFO)
    return
  end

  local words = {}
  local seen = {}
  for _, diag in ipairs(diagnostics) do
    local word = diag.message:match("['\"](.-)['\"]")
    if word and not seen[word] then
      seen[word] = true
      table.insert(words, word)
    end
  end

  if #words == 0 then
    vim.notify("No unknown words found", vim.log.levels.INFO)
    return
  end

  local config_path = vim.fn.findfile("codebook.toml", vim.fn.getcwd() .. ";")
  if config_path == "" then
    config_path = vim.fn.findfile(".codebook.toml", vim.fn.getcwd() .. ";")
  end
  if config_path == "" then
    config_path = vim.fn.getcwd() .. "/codebook.toml"
  end

  -- Read existing config
  local config = { words = {} }
  local file = io.open(config_path, "r")
  if file then
    local content = file:read("*a")
    file:close()
    -- Simple parsing for existing words (you might want a proper TOML parser)
    for line in content:gmatch("[^\n]+") do
      local word = line:match('^%s*"(.+)"%s*,?$')
      if word then
        table.insert(config.words, word)
      end
    end
  end

  -- Create a set of existing words for quick lookup
  local existing = {}
  for _, w in ipairs(config.words) do
    existing[w] = true
  end

  -- Add new words
  local added = 0
  for _, w in ipairs(words) do
    if not existing[w] then
      table.insert(config.words, w)
      added = added + 1
    end
  end

  if added == 0 then
    vim.notify("All words already in dictionary", vim.log.levels.INFO)
    return
  end

  -- Write TOML format
  file = io.open(config_path, "w")
  if not file then
    vim.notify("Failed to write to " .. config_path, vim.log.levels.ERROR)
    return
  end

  file:write("words = [\n")
  for i, w in ipairs(config.words) do
    file:write('  "' .. w .. '"')
    if i < #config.words then
      file:write(",")
    end
    file:write("\n")
  end
  file:write("]\n")
  file:close()

  -- Restart CodeBook LSP to pick up new words
  local client = vim.lsp.get_clients({ name = "codebook" })[1]
  if client then
    vim.lsp.stop_client(client.id)
    vim.defer_fn(function()
      vim.cmd("edit")
    end, 200)
  end

  vim.notify("Added " .. added .. " words to " .. config_path, vim.log.levels.INFO)
end, { desc = "CodeBook: Add all unknown words to dictionary" })

-- Cycle to next/previous buffer
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
