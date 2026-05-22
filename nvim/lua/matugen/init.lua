local M = { opts = {} }

local function notify(msg, lvl)
  vim.notify("matugen: " .. msg, lvl or vim.log.levels.INFO)
end

function M.load()
  local f = io.open(M.opts.json_path or "", "r")
  if not f then return notify("cannot open " .. (M.opts.json_path or ""), 3) end
  local raw = f:read("*a"):gsub("/%*.-%*/", ""):gsub("([^:])//[^\n]*", "%1")
  f:close()

  local ok, data = pcall(vim.json.decode, raw)
  local w = ok and data and data["workbench.colorCustomizations"]
  if not w then return notify("failed to parse JSONC", 3) end

  local function hex(v) return v and (#v == 9 and v:sub(1, 7) or v) end
  local c, templates, hl = nil, {}, function(g, o) vim.api.nvim_set_hl(0, g, o) end

  for _, file in ipairs(vim.api.nvim_get_runtime_file("lua/matugen/templates/**/*.lua", true)) do
    local mod = file:match("lua/(matugen/templates/.*)%.lua$"):gsub("/", ".")
    package.loaded[mod] = nil
    local res = require(mod)
    if type(res) == "function" then
      table.insert(templates, res)
    elseif mod:find("palette$") then
      c = res.get_colors(function(k) return hex(w[k]) end)
    end
  end

  if not c then return notify("palette not found", 3) end

  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
  vim.g.colors_name = "matugen"
  for _, t in ipairs(templates) do t(c, hl) end
end

function M.setup(opts)
  M.opts = opts or {}
  M.load()

  local signal = (vim.uv or vim.loop).new_signal()
  signal:start("sigusr1", vim.schedule_wrap(function()
    M.load()
    notify("theme reloaded")
  end))

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lazy", "mason", "lspinfo", "null-ls-info", "checkhealth" },
    callback = function() vim.wo.winblend = 10 end,
  })
end

return M
