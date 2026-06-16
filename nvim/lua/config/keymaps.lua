-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>cA", function()
  local diagnostics = vim.diagnostic.get(0, { source = "cSpell" })
  if #diagnostics == 0 then
    vim.notify("No cSpell diagnostics", vim.log.levels.INFO)
    return
  end

  local words = {}
  local seen = {}
  for _, diag in ipairs(diagnostics) do
    local word = diag.message:match('"(.-)"')
    if word and not seen[word] then
      seen[word] = true
      table.insert(words, word)
    end
  end

  local config_path = vim.fn.findfile("cspell.json", vim.fn.getcwd() .. ";")
  if config_path == "" then
    config_path = vim.fn.getcwd() .. "/cspell.json"
  end

  local config = { words = {} }
  local file = io.open(config_path, "r")
  if file then
    local ok, decoded = pcall(vim.json.decode, file:read("*a"))
    file:close()
    if ok and decoded then
      config = decoded
    end
  end
  if not config.words then
    config.words = {}
  end

  local existing = {}
  for _, w in ipairs(config.words) do
    existing[w] = true
  end

  local added = 0
  for _, w in ipairs(words) do
    if not existing[w] then
      table.insert(config.words, w)
      added = added + 1
    end
  end

  file = io.open(config_path, "w")
  if not file then
    vim.notify("Failed to write to " .. config_path, vim.log.levels.ERROR)
    return
  end

  local json = '{\n  "words": [\n'
  for i, w in ipairs(config.words) do
    json = json .. '    "' .. w .. '"'
    if i < #config.words then
      json = json .. ","
    end
    json = json .. "\n"
  end
  json = json .. "  ]\n}\n"
  file:write(json)
  file:close()

  -- restart cspell so it picks up the new words
  local client = vim.lsp.get_clients({ name = "cspell_ls" })[1]
  if client then
    vim.lsp.stop_client(client.id)
    vim.defer_fn(function()
      vim.cmd("edit")
    end, 200)
  end

  vim.notify("Added " .. added .. " words to " .. config_path, vim.log.levels.INFO)
end, { desc = "Cspell: Add all to dict" })
